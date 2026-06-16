import { DeviceInfo } from '../DeviceInfo';
import { TransferState } from '../TransferState';
import { ShareConstants } from '../constants/ShareConstants';
import { DeviceDiscoveryManager, DeviceFoundCallback, DiscoveryCompleteCallback } from './DeviceDiscoveryManager';
import { DataTransferManager, TransferProgressCallback } from './DataTransferManager';

/**
 * Typed container for session state data passed to callbacks.
 */
export class SessionStateData {
  deviceList: DeviceInfo[] | undefined;
  progress: number | undefined;
}

/**
 * Callback for session state changes.
 */
export type SessionStateCallback = (state: TransferState, data?: SessionStateData) => void;

/**
 * Callback invoked when share data is received from another device.
 */
export type DataReceivedCallback = (payload: string) => void;

/**
 * Singleton orchestrator for the entire share session lifecycle.
 * Coordinates device discovery and data transfer.
 */
export class ShareSessionManager {
  private static instance: ShareSessionManager | null = null;
  private discoveryManager: DeviceDiscoveryManager;
  private transferManager: DataTransferManager;
  private currentState: TransferState = TransferState.IDLE;
  private deviceList: DeviceInfo[] = [];
  private selectedDevice: DeviceInfo | null = null;
  private currentPayload: string = '';
  private onStateChange: SessionStateCallback | null = null;
  private onDataReceived: DataReceivedCallback | null = null;
  private context: Context | null = null;
  private retryCount: number = 0;

  private constructor() {
    this.discoveryManager = new DeviceDiscoveryManager();
    this.transferManager = new DataTransferManager();
  }

  static getInstance(): ShareSessionManager {
    if (ShareSessionManager.instance === null) {
      ShareSessionManager.instance = new ShareSessionManager();
    }
    return ShareSessionManager.instance;
  }

  /**
   * Set the application context for distributed service initialization.
   * Must be called before any share operations.
   */
  setContext(ctx: Context): void {
    if (this.context) {
      return; // Already set — singleton, no need to re-init
    }
    this.context = ctx;
    this.transferManager.setContext(ctx);
  }

  /**
   * Start listening for incoming share data from other devices.
   * Call once during app startup (e.g., in EntryAbility.onCreate).
   */
  startReceiving(onDataReceived?: DataReceivedCallback): void {
    if (onDataReceived) {
      this.onDataReceived = onDataReceived;
    }
    this.transferManager.startReceiving((payload: string) => {
      if (this.onDataReceived) {
        this.onDataReceived(payload);
      }
    });
  }

  startDiscovery(onStateChange: SessionStateCallback): void {
    this.onStateChange = onStateChange;
    this.deviceList = [];
    this.selectedDevice = null;
    this.setState(TransferState.DISCOVERING);

    const onDeviceFound: DeviceFoundCallback = (device: DeviceInfo) => {
      this.deviceList.push(device);
      if (this.onStateChange) {
        const data: SessionStateData = new SessionStateData();
        data.deviceList = this.deviceList;
        this.onStateChange(this.currentState, data);
      }
    };

    const onDiscoveryComplete: DiscoveryCompleteCallback = (_devices: DeviceInfo[]) => {
      if (this.deviceList.length === 0) {
        this.setState(TransferState.IDLE);
      }
    };

    this.discoveryManager.startDiscovery(onDeviceFound, onDiscoveryComplete);
  }

  sendToDevice(device: DeviceInfo, payload: string, isRetry: boolean = false): void {
    this.selectedDevice = device;
    this.currentPayload = payload;
    if (!isRetry) {
      this.retryCount = 0;
    }
    this.discoveryManager.stopDiscovery();
    this.setState(TransferState.CONNECTING);

    const onProgress: TransferProgressCallback = (progress: number, state: TransferState) => {
      const data: SessionStateData = new SessionStateData();
      data.progress = progress;
      this.setState(state, data);
    };

    const onComplete = (success: boolean, _error?: string) => {
      if (success) {
        const data: SessionStateData = new SessionStateData();
        data.progress = 100;
        this.setState(TransferState.DONE, data);
      } else {
        this.setState(TransferState.ERROR);
      }
    };

    this.transferManager.sendData(device.deviceId, payload, onProgress, onComplete);
  }

  retry(): void {
    if (this.retryCount >= ShareConstants.MAX_RETRY_COUNT) {
      this.setState(TransferState.ERROR);
      return;
    }
    if (this.selectedDevice && this.currentPayload) {
      this.retryCount++;
      this.sendToDevice(this.selectedDevice, this.currentPayload, true);
    }
  }

  getRetryCount(): number {
    return this.retryCount;
  }

  cancel(): void {
    this.discoveryManager.stopDiscovery();
    this.transferManager.cancelTransfer();
    this.deviceList = [];
    this.selectedDevice = null;
    this.currentPayload = '';
    this.setState(TransferState.IDLE);
  }

  getDeviceList(): DeviceInfo[] {
    return this.deviceList;
  }

  getCurrentState(): TransferState {
    return this.currentState;
  }

  isSimulatedMode(): boolean {
    return this.discoveryManager.isSimulatedMode();
  }

  private setState(state: TransferState, data?: SessionStateData): void {
    this.currentState = state;
    if (this.onStateChange) {
      this.onStateChange(state, data);
    }
  }
}
