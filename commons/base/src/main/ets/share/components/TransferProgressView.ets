import { TransferState } from '../TransferState';

/**
 * Transfer progress indicator component.
 * Shows circular progress with status text and success/error states.
 */
@Component
export struct TransferProgressView {
  @Prop transferProgress: number = 0;
  @Prop transferState: string = TransferState.IDLE;
  @Prop statusText: string = '';
  @Prop progressLabel: string = '';
  onRetry?: () => void;

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        // Background track
        Circle()
          .width(80)
          .height(80)
          .fill('#F1F3F5')

        // Progress arc
        Circle()
          .width(80)
          .height(80)
          .fill(Color.Transparent)
          .stroke('#CF0A2C')
          .strokeWidth(6)
          .strokeDashArray([Math.PI * 80])
          .strokeDashOffset(Math.PI * 80 * (1 - this.transferProgress / 100))
          .rotate({ angle: -90 })

        // State icon or percentage
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
      .width(80)
      .height(80)

      // Status text
      Text(this.statusText)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .margin({ top: 16 })

      // Progress detail
      if (this.transferState === TransferState.TRANSFERRING) {
        Text(this.progressLabel)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }

      // Retry button on error
      if (this.transferState === TransferState.ERROR && this.onRetry) {
        Button('重试')
          .fontSize(14)
          .fontColor('#CF0A2C')
          .backgroundColor('#FFF0F0')
          .borderRadius(20)
          .height(40)
          .width(100)
          .margin({ top: 16 })
          .onClick(() => {
            if (this.onRetry) {
              this.onRetry();
            }
          })
      }
    }
    .width('100%')
    .padding({ top: 32, bottom: 32 })
    .justifyContent(FlexAlign.Center)
  }
}
