import { DeviceInfo } from '../DeviceInfo';
import { TransferState } from '../TransferState';
import { ShareSessionManager, SessionStateCallback } from '../manager/ShareSessionManager';

/**
 * @Observed ViewModel that drives the share sheet UI.
 * Holds all reactive state: device list, transfer progress, status text, etc.
 */
@Observed
export class ShareViewModel {
  deviceList: DeviceInfo[] = [];
  transferState: TransferState = TransferState.IDLE;
  transferProgress: number = 0;
  selectedDevice: DeviceInfo | null = null;
  isSimulatedMode: boolean = false;
  statusText: string = '';
  progressLabel: string = '';
  payloadType: string = 'product';
  productPayload: string = '';
  appDataPayload: string = '';

  private sessionManager: ShareSessionManager = ShareSessionManager.getInstance();
  private context: Context | null = null;

  /**
   * Initialize the ViewModel with an optional context for string lookups.
   */
  init(context?: Context): void {
    if (context) {
      this.context = context;
    }
    this.reset();
  }

  /**
   * Start device discovery.
   */
  startDiscovery(payloadType: string, payloadJson: string): void {
    this.reset();
    this.payloadType = payloadType;
    if (payloadType === 'product') {
      this.productPayload = payloadJson;
    } else {
      this.appDataPayload = payloadJson;
    }
    this.transferState = TransferState.DISCOVERING;
    this.statusText = this.getStatusText();
    this.isSimulatedMode = this.sessionManager.isSimulatedMode();

    const callback: SessionStateCallback = (state: TransferState, data?: Object) => {
      this.transferState = state;
      this.statusText = this.getStatusText();

      if (data) {
        const extra = data as Record<string, Object>;
        if (extra['deviceList'] !== undefined) {
          this.deviceList = extra['deviceList'] as DeviceInfo[];
        }
        if (extra['progress'] !== undefined) {
          this.transferProgress = extra['progress'] as number;
          this.progressLabel = `已发送 ${this.transferProgress}%`;
        }
      }

      if (state === TransferState.DONE) {
        this.transferProgress = 100;
        this.progressLabel = '发送完成';
      }
    };

    this.sessionManager.startDiscovery(callback);
  }

  /**
   * User selects a device from the list.
   */
  selectDevice(device: DeviceInfo): void {
    this.selectedDevice = device;
    const payload = this.payloadType === 'product' ? this.productPayload : this.appDataPayload;
    this.sessionManager.sendToDevice(device, payload);
  }

  /**
   * Retry failed transfer.
   */
  retry(): void {
    this.sessionManager.retry();
  }

  /**
   * Cancel and reset the session.
   */
  cancel(): void {
    this.sessionManager.cancel();
    this.reset();
  }

  /**
   * Reset all state to defaults.
   */
  reset(): void {
    this.deviceList = [];
    this.transferState = TransferState.IDLE;
    this.transferProgress = 0;
    this.selectedDevice = null;
    this.statusText = '';
    this.progressLabel = '';
    this.isSimulatedMode = false;
  }

  /**
   * Get human-readable status text based on current state.
   */
  private getStatusText(): string {
    switch (this.transferState) {
      case TransferState.DISCOVERING:
        return '正在搜索附近设备...';
      case TransferState.CONNECTING:
        return '正在连接设备...';
      case TransferState.TRANSFERRING:
        return '正在发送...';
      case TransferState.DONE:
        return '发送成功';
      case TransferState.ERROR:
        return '发送失败，请重试';
      default:
        return '';
    }
  }
}
