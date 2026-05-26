export class ShareConstants {
  /** KV store name for distributed data transfer */
  static readonly KV_STORE_ID: string = 'airdrop_share_store';

  /** Timeout for device discovery in milliseconds */
  static readonly DISCOVERY_TIMEOUT: number = 8000;

  /** Simulated transfer duration in milliseconds */
  static readonly SIMULATED_TRANSFER_DURATION: number = 2000;

  /** Max retry attempts */
  static readonly MAX_RETRY_COUNT: number = 3;

  /** TCP port for socket fallback transfer */
  static readonly SOCKET_PORT: number = 18888;

  /** Mock devices for demo mode when no real distributed devices are available */
  static readonly MOCK_DEVICES: Array<{ name: string; type: string; id: string }> = [
    { name: 'HUAWEI Mate 60 Pro', type: 'phone', id: 'mock-device-001' },
    { name: 'HUAWEI MatePad Pro', type: 'tablet', id: 'mock-device-002' },
    { name: 'HUAWEI P60 Pro', type: 'phone', id: 'mock-device-003' }
  ];

  /** AppStorage key for received share data notification */
  static readonly RECEIVED_SHARE_KEY: string = 'received_share_data';

  /** Share sheet title */
  static readonly SHARE_TITLE = (context: Context): string =>
    context.resourceManager.getStringSync($r('app.string.share_title', context).id);

  /** Share sheet subtitle */
  static readonly SHARE_SUBTITLE = (context: Context): string =>
    context.resourceManager.getStringSync($r('app.string.share_subtitle', context).id);
}
