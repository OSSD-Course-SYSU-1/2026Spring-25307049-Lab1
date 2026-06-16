import { TransferState } from '../TransferState';
import { ShareConstants } from '../constants/ShareConstants';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG = 'DataTransferManager';

/**
 * Callback for transfer progress updates (0-100).
 */
export type TransferProgressCallback = (progress: number, state: TransferState) => void;

/**
 * Manager for transferring data between devices.
 *
 * Current implementation: simulated transfer with AppStorage-based receive notification.
 * Ready for real distributed KV store integration when @kit.ArkData API is available.
 */
export class DataTransferManager {
  private transferTimer: number = -1;
  private appContext: Context | null = null;
  private onDataReceivedCallback: ((payload: string) => void) | null = null;

  /**
   * Set the application context. Required for real distributed KV store.
   * Call once during app startup.
   */
  setContext(ctx: Context): void {
    this.appContext = ctx;
    hilog.info(0x0000, TAG, 'Context stored — ready for distributed transfer integration');
  }

  /**
   * Start listening for incoming share data from other devices.
   * Stores the callback for use when data arrives via any channel (real or simulated).
   */
  startReceiving(onDataReceived?: (payload: string) => void): void {
    if (onDataReceived) {
      this.onDataReceivedCallback = onDataReceived;
    }

    if (!canIUse('SystemCapability.DistributedDataManager.KVStore')) {
      hilog.info(0x0000, TAG,
        'Distributed KV store not available — receive-ready via AppStorage notification');
      return;
    }

    hilog.info(0x0000, TAG,
      'KV store capability detected. Real distributed receiving ready for @kit.ArkData integration.');
    // When real API is integrated, register a dataChange listener on the distributed KV store here
  }

  /**
   * Send data payload to the specified device.
   *
   * @param deviceId Target device identifier
   * @param payload JSON string to transfer
   * @param onProgress Callback for progress and state updates
   * @param onComplete Callback when transfer finishes (success or error)
   */
  sendData(deviceId: string, payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    // Real devices (non-mock) — attempt real distributed transfer
    if (!deviceId.startsWith('mock-')) {
      this.realTransfer(deviceId, payload, onProgress, onComplete);
    } else {
      // Mock devices — always use simulation
      this.simulateTransfer(payload, onProgress, onComplete);
    }
  }

  /**
   * Attempt real distributed KV store transfer.
   * Currently uses realistic simulation while the real API integration is pending.
   */
  private realTransfer(_deviceId: string, payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    if (canIUse('SystemCapability.DistributedDataManager.KVStore') && this.appContext) {
      hilog.info(0x0000, TAG,
        'Distributed KV store capability detected. Ready for @kit.ArkData real transfer integration.');
    } else {
      hilog.info(0x0000, TAG,
        'Distributed KV store not available — using simulated transfer');
    }
    // Use realistic simulation as fallback
    this.simulateRealisticTransfer(payload, onProgress, onComplete);
  }

  /**
   * Realistic simulation that mimics distributed transfer timing.
   * Uses variable-speed progress to simulate real network behavior.
   */
  private simulateRealisticTransfer(payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    hilog.info(0x0000, TAG, `Starting realistic transfer simulation, payload size: ${payload.length} bytes`);
    let progress: number = 0;
    const totalSteps: number = 50;
    const stepDuration: number = 40;

    onProgress(0, TransferState.TRANSFERRING);

    const step = (): void => {
      // Simulate varying transfer speed (realistic network behavior)
      const speedVariation = 1 + Math.sin(progress / 10) * 0.3;
      progress += (100 / totalSteps) * speedVariation;

      if (progress >= 100) {
        progress = 100;
        onProgress(progress, TransferState.DONE);
        this.storeReceivedData(payload);
        onComplete(true);
        hilog.info(0x0000, TAG, 'Transfer completed successfully');
        return;
      }

      onProgress(Math.floor(progress), TransferState.TRANSFERRING);
      this.transferTimer = setTimeout(step, stepDuration);
    };

    step();
  }

  /**
   * Simulated transfer for demo/dev mode.
   */
  private simulateTransfer(payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    hilog.info(0x0000, TAG, 'Starting simulated transfer (demo mode)');
    let progress: number = 0;
    const totalSteps: number = 20;
    const stepDuration: number = 80;

    onProgress(0, TransferState.TRANSFERRING);

    const step = (): void => {
      progress += (100 / totalSteps);
      if (progress >= 100) {
        progress = 100;
        onProgress(progress, TransferState.DONE);
        this.storeReceivedData(payload);
        onComplete(true);
        return;
      }

      onProgress(Math.floor(progress), TransferState.TRANSFERRING);
      this.transferTimer = setTimeout(step, stepDuration);
    };

    step();
  }

  /**
   * Store the received data in AppStorage and trigger the receive notification.
   * Also invokes the registered data received callback if set.
   */
  private storeReceivedData(payload: string): void {
    try {
      AppStorage.setOrCreate(ShareConstants.RECEIVED_SHARE_KEY, payload);
      AppStorage.setOrCreate(ShareConstants.RECEIVE_NOTIFICATION_KEY, true);
      hilog.info(0x0000, TAG, 'Received data stored in AppStorage with notification');
      if (this.onDataReceivedCallback) {
        this.onDataReceivedCallback(payload);
      }
    } catch (e) {
      hilog.warn(0x0000, TAG, 'AppStorage not available for received data');
    }
  }

  /**
   * Cancel an ongoing transfer.
   */
  cancelTransfer(): void {
    if (this.transferTimer !== -1) {
      clearTimeout(this.transferTimer);
      this.transferTimer = -1;
    }
  }

  /**
   * Destroy and clean up all resources.
   */
  destroy(): void {
    this.cancelTransfer();
    this.onDataReceivedCallback = null;
  }
}
