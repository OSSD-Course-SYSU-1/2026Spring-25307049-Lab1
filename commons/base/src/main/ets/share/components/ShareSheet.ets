import { DeviceInfo } from '../DeviceInfo';
import { TransferState } from '../TransferState';
import { ShareSessionManager, SessionStateCallback } from '../manager/ShareSessionManager';

/**
 * Bottom sheet component for the "AirDrop" sharing feature.
 * Self-contained state management for device discovery + transfer.
 */
@Component
export struct ShareSheet {
  @Link isVisible: boolean;
  @Prop payloadType: string = 'product';
  @Prop payloadJson: string = '';
  @State deviceList: DeviceInfo[] = [];
  @State transferState: string = TransferState.IDLE;
  @State transferProgress: number = 0;
  @State statusText: string = '';
  @State progressLabel: string = '';
  @State isSimulatedMode: boolean = false;
  @State radarAngle: number = 0;
  @State sheetTranslateY: number = 100;
  private sessionManager: ShareSessionManager = ShareSessionManager.getInstance();
  private radarTimer: number = -1;

  aboutToAppear(): void {
    animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
      this.sheetTranslateY = 0;
    });
    this.startDiscovery();
    this.startRadarAnimation();
  }

  aboutToDisappear(): void {
    this.stopRadarAnimation();
    this.sessionManager.cancel();
  }

  startRadarAnimation(): void {
    let angle: number = 0;
    const rotate = (): void => {
      if (!this.isVisible) {
        return;
      }
      angle = (angle + 6) % 360;
      this.radarAngle = angle;
      if (this.transferState === TransferState.DISCOVERING) {
        this.radarTimer = setTimeout(rotate, 33);
      }
    };
    this.radarTimer = setTimeout(rotate, 33);
  }

  stopRadarAnimation(): void {
    if (this.radarTimer !== -1) {
      clearTimeout(this.radarTimer);
      this.radarTimer = -1;
    }
  }

  startDiscovery(): void {
    this.deviceList = [];
    this.transferState = TransferState.DISCOVERING;
    this.transferProgress = 0;
    this.statusText = '正在搜索附近设备...';
    this.isSimulatedMode = true;

    const callback: SessionStateCallback = (state: TransferState, data?: Object): void => {
      this.transferState = state;
      this.updateStatusText();

      if (data) {
        const extra = data as Record<string, Object>;
        if (extra['deviceList'] !== undefined) {
          this.deviceList = extra['deviceList'] as DeviceInfo[];
        }
        if (extra['progress'] !== undefined) {
          this.transferProgress = extra['progress'] as number;
          this.progressLabel = '已发送 ' + Math.floor(this.transferProgress) + '%';
        }
      }
      if (state === TransferState.DONE) {
        this.transferProgress = 100;
        this.progressLabel = '发送完成';
      }
    };

    this.sessionManager.startDiscovery(callback);
  }

  selectDevice(device: DeviceInfo): void {
    this.sessionManager.sendToDevice(device, this.payloadJson);
  }

  retry(): void {
    this.sessionManager.retry();
  }

  updateStatusText(): void {
    switch (this.transferState) {
      case TransferState.DISCOVERING:
        this.statusText = '正在搜索附近设备...';
        break;
      case TransferState.CONNECTING:
        this.statusText = '正在连接设备...';
        break;
      case TransferState.TRANSFERRING:
        this.statusText = '正在发送...';
        break;
      case TransferState.DONE:
        this.statusText = '发送成功';
        break;
      case TransferState.ERROR:
        this.statusText = '发送失败，请重试';
        break;
      default:
        this.statusText = '';
    }
  }

  dismiss(): void {
    if (this.transferState === TransferState.TRANSFERRING) {
      return;
    }
    this.stopRadarAnimation();
    animateTo({ duration: 250, curve: Curve.EaseIn }, () => {
      this.sheetTranslateY = 100;
    });
    setTimeout(() => {
      this.isVisible = false;
    }, 260);
  }

  build() {
    Column() {
      // Backdrop
      Column()
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#4D000000')
        .onClick(() => { this.dismiss(); })

      // Sheet
      Column() {
        // Drag bar
        Row() {
          Row()
            .width(36)
            .height(4)
            .backgroundColor('#D9D9D9')
            .borderRadius(2)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 10, bottom: 4 })

        Text('隔空投送')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 8 })

        Text('选择附近的设备进行分享')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4, bottom: 16 })

        if (this.isSimulatedMode &&
          (this.transferState === TransferState.DISCOVERING || this.transferState === TransferState.IDLE)) {
          Text('演示模式')
            .fontSize(10)
            .fontColor('#FF9800')
            .backgroundColor('#FFF3E0')
            .borderRadius(8)
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .margin({ bottom: 8 })
        }

        if (this.transferState === TransferState.DISCOVERING || this.transferState === TransferState.IDLE) {
          this.DiscoveryContent()
        } else {
          this.TransferContent()
        }

        if (this.transferState === TransferState.IDLE || this.transferState === TransferState.DISCOVERING) {
          Button('取消')
            .fontSize(15)
            .fontColor('#CF0A2C')
            .backgroundColor('#FFF0F0')
            .borderRadius(22)
            .height(44)
            .width('88%')
            .margin({ top: 12, bottom: 28 })
            .onClick(() => { this.dismiss(); })
        }
      }
      .width('100%')
      .backgroundColor('#F5F6FA')
      .borderRadius({ topLeft: 20, topRight: 20 })
      .translate({ y: this.sheetTranslateY })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DiscoveryContent() {
    Column() {
      if (this.deviceList.length === 0) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(120).height(120)
            .stroke('#E0E0E0').strokeWidth(1)
            .fill(Color.Transparent)
          Circle()
            .width(90).height(90)
            .stroke('#E8E8E8').strokeWidth(1)
            .fill(Color.Transparent)
          Circle()
            .width(120).height(120)
            .fill(new LinearGradient([
              { color: '#4DC4E8FF', offset: 0 },
              { color: '#00C4E8FF', offset: 1 }
            ]))
            .sweepAngle(60)
            .startAngle(this.radarAngle - 60)
            .rotate({ angle: this.radarAngle })
            .opacity(0.4)
          Text('📤')
            .fontSize(28)
            .opacity(0.6)
        }
        .width(120).height(120)
        .margin({ bottom: 12 })

        LoadingProgress()
          .width(24).height(24)
          .color('#CF0A2C')
          .margin({ bottom: 8 })

        Text('正在搜索附近设备...')
          .fontSize(13)
          .fontColor('#999999')
      }

      if (this.deviceList.length > 0) {
        List() {
          ForEach(this.deviceList, (device: DeviceInfo) => {
            ListItem() {
              Row() {
                Text(device.deviceType === 'tablet' ? '📱' : '📱')
                  .fontSize(28)
                Column() {
                  Text(device.deviceName)
                    .fontSize(15).fontWeight(FontWeight.Medium).fontColor('#333333')
                  Text(device.isSimulated ? '模拟设备' : 'HarmonyOS 设备')
                    .fontSize(11).fontColor('#999999').margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 12 })
                .layoutWeight(1)
                Text('›')
                  .fontSize(22)
                  .fontColor('#CCCCCC')
              }
              .width('100%').height(64)
              .padding({ left: 16, right: 16 })
              .backgroundColor(Color.White)
              .borderRadius(12)
              .margin({ bottom: 8 })
              .onClick(() => { this.selectDevice(device); })
            }
          }, (device: DeviceInfo) => device.deviceId)
        }
        .scrollBar(BarState.Off)
        .height(180)
        .margin({ left: 16, right: 16 })
      }

      if (this.deviceList.length === 0 && this.transferState !== TransferState.DISCOVERING) {
        Column() {
          Text('📤')
            .fontSize(48)
            .opacity(0.3)
            .margin({ top: 24 })
          Text('未发现附近设备')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 12 })
        }
      }
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }

  @Builder
  TransferContent() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(80).height(80)
          .fill('#F1F3F5')
        Circle()
          .width(80).height(80)
          .fill(Color.Transparent)
          .stroke('#CF0A2C')
          .strokeWidth(6)
          .strokeDashArray([Math.PI * 80])
          .strokeDashOffset(Math.PI * 80 * (1 - this.transferProgress / 100))
          .rotate({ angle: -90 })

        if (this.transferState === TransferState.DONE) {
          Text('✓')
            .fontSize(36)
            .fontColor('#4CAF50')
            .fontWeight(FontWeight.Bold)
        } else if (this.transferState === TransferState.ERROR) {
          Text('✗')
            .fontSize(36)
            .fontColor('#FF5252')
            .fontWeight(FontWeight.Bold)
        } else {
          Text(Math.floor(this.transferProgress).toString() + '%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#CF0A2C')
        }
      }
      .width(80).height(80)

      Text(this.statusText)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .margin({ top: 16 })

      if (this.transferState === TransferState.TRANSFERRING) {
        Text(this.progressLabel)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }

      if (this.transferState === TransferState.ERROR) {
        Button('重试')
          .fontSize(14)
          .fontColor('#CF0A2C')
          .backgroundColor('#FFF0F0')
          .borderRadius(20)
          .height(40)
          .width(100)
          .margin({ top: 16 })
          .onClick(() => { this.retry(); })
      }
    }
    .width('100%')
    .padding({ top: 32, bottom: 32 })
    .justifyContent(FlexAlign.Center)
  }
}
