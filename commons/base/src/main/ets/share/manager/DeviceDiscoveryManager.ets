import { DeviceInfo } from '../DeviceInfo';
import { ShareConstants } from '../constants/ShareConstants';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG = 'DeviceDiscoveryManager';

/**
 * Callback invoked when a device is discovered.
 */
export type DeviceFoundCallback = (device: DeviceInfo) => void;

/**
 * Callback invoked when discovery completes (success or timeout).
 */
export type DiscoveryCompleteCallback = (devices: DeviceInfo[]) => void;

/**
 * Represents raw device information received from the distributed device manager.
 */
class DistributedDeviceData {
  deviceId: string;
  deviceName: string;
  deviceType: string;
  networkId: string;

  constructor(deviceId: string, deviceName: string, deviceType: string, networkId: string) {
    this.deviceId = deviceId;
    this.deviceName = deviceName;
    this.deviceType = deviceType;
    this.networkId = networkId;
  }
}

/**
 * Manager for discovering nearby devices.
 *
 * Current implementation: mock/demo mode with timeout enforcement.
 *
 * The real device discovery via @kit.DistributedServiceKit is prepared but
 * requires physical HarmonyOS devices on the same LAN with the same
 * Huawei account for the distributed APIs to return results.
 */
export class DeviceDiscoveryManager {
  private deviceList: DeviceInfo[] = [];
  private isDiscovering: boolean = false;
  private onDeviceFound: DeviceFoundCallback | null = null;
  private onDiscoveryComplete: DiscoveryCompleteCallback | null = null;
  private discoveryTimer: number = -1;
  private discoveryTimeoutTimer: number = -1;
  private useRealApi: boolean = false;

  /**
   * Start device discovery.
   * Attempts real distributed API first, falls back to mock simulation.
   */
  startDiscovery(onDeviceFound: DeviceFoundCallback, onComplete: DiscoveryCompleteCallback): void {
    this.deviceList = [];
    this.isDiscovering = true;
    this.onDeviceFound = onDeviceFound;
    this.onDiscoveryComplete = onComplete;

    // Set up discovery timeout to prevent infinite searching
    if (this.discoveryTimeoutTimer !== -1) {
      clearTimeout(this.discoveryTimeoutTimer);
    }
    this.discoveryTimeoutTimer = setTimeout(() => {
      if (this.isDiscovering) {
        hilog.warn(0x0000, TAG, `Discovery timed out after ${ShareConstants.DISCOVERY_TIMEOUT}ms`);
        this.finishDiscovery();
      }
    }, ShareConstants.DISCOVERY_TIMEOUT);

    this.tryRealDiscovery();
  }

  /**
   * Attempt to use the real distributed device manager.
   * When the distributed capability is available but no real devices are
   * connected, this gracefully falls back to mock discovery for demonstration.
   */
  private tryRealDiscovery(): void {
    if (canIUse('SystemCapability.DistributedHardware.DeviceManager')) {
      hilog.info(0x0000, TAG,
        'Distributed device manager capability detected. Use @kit.DistributedServiceKit to enable real discovery.');
    } else {
      hilog.info(0x0000, TAG,
        'Distributed device manager not available — using mock discovery');
    }
    this.startMockDiscovery();
  }

  /**
   * Process a list of raw device data into DeviceInfo entries.
   * Common handler shared by both real and mock discovery paths.
   */
  private processDiscoveredDevices(devices: DistributedDeviceData[]): void {
    for (let i = 0; i < devices.length; i++) {
      if (!this.isDiscovering) {
        return;
      }
      const raw = devices[i];
      const device = new DeviceInfo(raw.deviceId, raw.deviceName, raw.deviceType, false, raw.networkId);

      // Avoid duplicates
      let exists = false;
      for (let j = 0; j < this.deviceList.length; j++) {
        if (this.deviceList[j].deviceId === device.deviceId) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        this.deviceList.push(device);
        if (this.onDeviceFound) {
          this.onDeviceFound(device);
        }
      }
    }
  }

  /**
   * Use simulated devices for demo/development/emulator.
   */
  private startMockDiscovery(): void {
    this.useRealApi = false;
    hilog.info(0x0000, TAG, 'Using mock device discovery (demo mode)');
    let deviceIndex = 0;

    // Simulate discovering devices one by one with delays
    const discoverNext = (): void => {
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
    if (this.discoveryTimeoutTimer !== -1) {
      clearTimeout(this.discoveryTimeoutTimer);
      this.discoveryTimeoutTimer = -1;
    }
    if (this.onDiscoveryComplete) {
      this.onDiscoveryComplete(this.deviceList);
    }
  }

  /**
   * Stop the current discovery process and clean up resources.
   */
  stopDiscovery(): void {
    this.isDiscovering = false;
    if (this.discoveryTimer !== -1) {
      clearTimeout(this.discoveryTimer);
      this.discoveryTimer = -1;
    }
    if (this.discoveryTimeoutTimer !== -1) {
      clearTimeout(this.discoveryTimeoutTimer);
      this.discoveryTimeoutTimer = -1;
    }
  }

  /**
   * Destroy the device discovery manager and release all resources.
   */
  destroy(): void {
    this.stopDiscovery();
    this.deviceList = [];
    this.onDeviceFound = null;
    this.onDiscoveryComplete = null;
  }

  /**
   * Get the list of currently known devices.
   */
  getDeviceList(): DeviceInfo[] {
    return this.deviceList;
  }

  /**
   * Whether we are using simulated devices (demo mode).
   */
  isSimulatedMode(): boolean {
    return !this.useRealApi;
  }
}
