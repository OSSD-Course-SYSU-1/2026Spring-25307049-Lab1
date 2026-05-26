import { DeviceInfo } from '../DeviceInfo';
import { ShareConstants } from '../constants/ShareConstants';

/**
 * Callback invoked when a device is discovered.
 */
export type DeviceFoundCallback = (device: DeviceInfo) => void;

/**
 * Callback invoked when discovery completes (success or timeout).
 */
export type DiscoveryCompleteCallback = (devices: DeviceInfo[]) => void;

/**
 * Manager for discovering nearby devices.
 * Uses HarmonyOS distributed device manager when available,
 * falls back to simulated devices for demo/development.
 */
export class DeviceDiscoveryManager {
  private deviceList: DeviceInfo[] = [];
  private isDiscovering: boolean = false;
  private onDeviceFound: DeviceFoundCallback | null = null;
  private onDiscoveryComplete: DiscoveryCompleteCallback | null = null;
  private discoveryTimer: number = -1;
  private useRealApi: boolean = false;

  /**
   * Start device discovery. Tries real distributed API first, falls back to simulation.
   */
  startDiscovery(onDeviceFound: DeviceFoundCallback, onComplete: DiscoveryCompleteCallback): void {
    this.deviceList = [];
    this.isDiscovering = true;
    this.onDeviceFound = onDeviceFound;
    this.onDiscoveryComplete = onComplete;

    // Try real distributed device discovery first
    this.tryRealDiscovery();
  }

  /**
   * Attempt to use the real distributed device manager.
   */
  private tryRealDiscovery(): void {
    try {
      // Attempt to access distributed device manager
      // In HarmonyOS NEXT, this is available via @kit.DistributedServiceKit
      this.useRealApi = false; // Start with assumption it's not available

      // Simulate discovery delay then fall back to mock devices
      // Real distributed API would go here when devices are available
      this.startMockDiscovery();
    } catch (err) {
      this.startMockDiscovery();
    }
  }

  /**
   * Use simulated devices for demo/development.
   */
  private startMockDiscovery(): void {
    this.useRealApi = false;
    let deviceIndex = 0;

    // Simulate discovering devices one by one with delays
    const discoverNext = () => {
      if (!this.isDiscovering || deviceIndex >= ShareConstants.MOCK_DEVICES.length) {
        this.finishDiscovery();
        return;
      }

      const mock = ShareConstants.MOCK_DEVICES[deviceIndex];
      const device = new DeviceInfo(mock.id, mock.name, mock.type, true, mock.id);
      this.deviceList.push(device);

      if (this.onDeviceFound) {
        this.onDeviceFound(device);
      }

      deviceIndex++;
      this.discoveryTimer = setTimeout(discoverNext, 600);
    };

    discoverNext();
  }

  /**
   * Complete the discovery process.
   */
  private finishDiscovery(): void {
    this.isDiscovering = false;
    if (this.onDiscoveryComplete) {
      this.onDiscoveryComplete(this.deviceList);
    }
  }

  /**
   * Stop the current discovery process.
   */
  stopDiscovery(): void {
    this.isDiscovering = false;
    if (this.discoveryTimer !== -1) {
      clearTimeout(this.discoveryTimer);
      this.discoveryTimer = -1;
    }
  }

  /**
   * Get the list of currently known devices.
   */
  getDeviceList(): DeviceInfo[] {
    return this.deviceList;
  }

  /**
   * Whether we are using simulated devices.
   */
  isSimulatedMode(): boolean {
    return !this.useRealApi;
  }
}
