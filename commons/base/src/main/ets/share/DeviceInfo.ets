/**
 * Model representing a discovered nearby device for sharing.
 */
export class DeviceInfo {
  deviceId: string;
  deviceName: string;
  deviceType: string; // 'phone' | 'tablet' | '2in1'
  isSimulated: boolean;
  networkId: string;

  constructor(deviceId: string, deviceName: string, deviceType: string, isSimulated: boolean = false,
    networkId: string = '') {
    this.deviceId = deviceId;
    this.deviceName = deviceName;
    this.deviceType = deviceType;
    this.isSimulated = isSimulated;
    this.networkId = networkId;
  }
}
