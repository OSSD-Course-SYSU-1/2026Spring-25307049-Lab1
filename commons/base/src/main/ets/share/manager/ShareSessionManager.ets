import { DeviceInfo } from '../DeviceInfo';
import { TransferState } from '../TransferState';
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

  sendToDevice(device: DeviceInfo, payload: string): void {
    this.selectedDevice = device;
    this.currentPayload = payload;
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
    if (this.selectedDevice && this.currentPayload) {
      this.sendToDevice(this.selectedDevice, this.currentPayload);
    }
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
