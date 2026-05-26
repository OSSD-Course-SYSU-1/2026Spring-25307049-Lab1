/**
 * Data class for mock device entries.
 */
export class MockDeviceEntry {
  name: string;
  type: string;
  id: string;

  constructor(name: string, type: string, id: string) {
    this.name = name;
    this.type = type;
    this.id = id;
  }
}

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
  static readonly MOCK_DEVICES: MockDeviceEntry[] = [
    new MockDeviceEntry('HUAWEI Mate 60 Pro', 'phone', 'mock-device-001'),
    new MockDeviceEntry('HUAWEI MatePad Pro', 'tablet', 'mock-device-002'),
    new MockDeviceEntry('HUAWEI P60 Pro', 'phone', 'mock-device-003')
  ];

  /** AppStorage key for received share data notification */
  static readonly RECEIVED_SHARE_KEY: string = 'received_share_data';
}
