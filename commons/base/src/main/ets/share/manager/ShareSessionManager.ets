import { DeviceInfo } from '../DeviceInfo';
import { TransferState } from '../TransferState';
import { DeviceDiscoveryManager, DeviceFoundCallback, DiscoveryCompleteCallback } from './DeviceDiscoveryManager';
import { DataTransferManager, TransferProgressCallback } from './DataTransferManager';

/**
 * Callback for session state changes.
 */
export type SessionStateCallback = (state: TransferState, data?: Object) => void;

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
   * Start device discovery. Notifies callback as state and device list change.
   */
  startDiscovery(onStateChange: SessionStateCallback): void {
    this.onStateChange = onStateChange;
    this.deviceList = [];
    this.selectedDevice = null;
    this.setState(TransferState.DISCOVERING);

    const onDeviceFound: DeviceFoundCallback = (device: DeviceInfo) => {
      this.deviceList.push(device);
      if (this.onStateChange) {
        this.onStateChange(this.currentState, { deviceList: this.deviceList });
      }
    };

    const onDiscoveryComplete: DiscoveryCompleteCallback = (_devices: DeviceInfo[]) => {
      // If no devices found, stay in IDLE (UI shows empty state)
      if (this.deviceList.length === 0) {
        this.setState(TransferState.IDLE);
      }
    };

    this.discoveryManager.startDiscovery(onDeviceFound, onDiscoveryComplete);
  }

  /**
   * Select a device and initiate transfer.
   */
  sendToDevice(device: DeviceInfo, payload: string): void {
    this.selectedDevice = device;
    this.currentPayload = payload;
    this.discoveryManager.stopDiscovery();
    this.setState(TransferState.CONNECTING);

    const onProgress: TransferProgressCallback = (progress: number, state: TransferState) => {
      this.setState(state, { progress: progress });
    };

    const onComplete = (success: boolean, _error?: string) => {
      if (success) {
        this.setState(TransferState.DONE, { progress: 100 });
      } else {
        this.setState(TransferState.ERROR);
      }
    };

    this.transferManager.sendData(device.deviceId, payload, onProgress, onComplete);
  }

  /**
   * Retry the last failed transfer.
   */
  retry(): void {
    if (this.selectedDevice && this.currentPayload) {
      this.sendToDevice(this.selectedDevice, this.currentPayload);
    }
  }

  /**
   * Cancel the current session.
   */
  cancel(): void {
    this.discoveryManager.stopDiscovery();
    this.transferManager.cancelTransfer();
    this.deviceList = [];
    this.selectedDevice = null;
    this.currentPayload = '';
    this.setState(TransferState.IDLE);
  }

  /**
   * Get the current list of discovered devices.
   */
  getDeviceList(): DeviceInfo[] {
    return this.deviceList;
  }

  /**
   * Get the current transfer state.
   */
  getCurrentState(): TransferState {
    return this.currentState;
  }

  /**
   * Whether we are in simulated mode.
   */
  isSimulatedMode(): boolean {
    return this.discoveryManager.isSimulatedMode();
  }

  private setState(state: TransferState, data?: Object): void {
    this.currentState = state;
    if (this.onStateChange) {
      this.onStateChange(state, data);
    }
  }
}
