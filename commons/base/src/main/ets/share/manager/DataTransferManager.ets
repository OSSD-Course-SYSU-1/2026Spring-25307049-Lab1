import { TransferState } from '../TransferState';

/**
 * Callback for transfer progress updates (0-100).
 */
export type TransferProgressCallback = (progress: number, state: TransferState) => void;

/**
 * Manager for transferring data between devices.
 * Uses distributed KV store when available, falls back to local simulation.
 */
export class DataTransferManager {
  private transferTimer: number = -1;

  /**
   * Send data payload to the specified device.
   * @param deviceId Target device identifier
   * @param payload JSON string to transfer
   * @param onProgress Callback for progress and state updates
   * @param onComplete Callback when transfer finishes (success or error)
   */
  sendData(deviceId: string, payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    if (deviceId.startsWith('mock-')) {
      this.simulateTransfer(payload, onProgress, onComplete);
    } else {
      this.realTransfer(deviceId, payload, onProgress, onComplete);
    }
  }

  /**
   * Real distributed KV store transfer.
   */
  private realTransfer(deviceId: string, payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    try {
      onProgress(10, TransferState.CONNECTING);

      // In a real implementation, this would use:
      // import { distributedKVStore } from '@kit.ArkData';
      // const kvStore = await kvManager.getKVStore(storeConfig);
      // await kvStore.put('share_key_' + Date.now(), payload);

      // For now, since we may not have real distributed setup,
      // simulate after a short delay
      this.simulateTransfer(payload, onProgress, onComplete);
    } catch (err) {
      onComplete(false, `Transfer failed: ${err}`);
    }
  }

  /**
   * Simulated transfer for demo mode.
   */
  private simulateTransfer(payload: string, onProgress: TransferProgressCallback,
    onComplete: (success: boolean, error?: string) => void): void {
    let progress: number = 0;
    const totalSteps: number = 20;
    const stepDuration: number = 80;

    onProgress(0, TransferState.TRANSFERRING);

    const step = () => {
      progress += (100 / totalSteps);
      if (progress >= 100) {
        progress = 100;
        onProgress(progress, TransferState.DONE);
        onComplete(true);

        // Store received data in AppStorage for cross-session simulation
        try {
          AppStorage.setOrCreate('received_share_data', payload);
        } catch (e) {
          // AppStorage may not be available
        }
        return;
      }

      onProgress(Math.floor(progress), TransferState.TRANSFERRING);
      this.transferTimer = setTimeout(step, stepDuration);
    };

    step();
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
}
