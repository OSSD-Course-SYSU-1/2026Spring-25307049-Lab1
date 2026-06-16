import { ShareConstants } from '../constants/ShareConstants';
import { ProductSharePayload, AppDataSharePayload } from '../ShareData';
import { CommonConstants } from '../../constants/CommonConstants';

/**
 * Receive notification overlay that appears when share data is received
 * from another device. Shows a preview of the incoming data with
 * accept/decline options.
 */
@Component
export struct ReceiveNotification {
  @StorageLink(ShareConstants.RECEIVE_NOTIFICATION_KEY) isVisible: boolean = false;
  @StorageLink(ShareConstants.RECEIVED_SHARE_KEY) receivedData: string = '';
  @State isAccepted: boolean = false;
  @State isDismissed: boolean = false;
  @State parseResult: ReceivePayloadPreview | null = null;
  private autoDismissTimer: number = -1;

  aboutToAppear(): void {
    this.parseData();
    // Auto-dismiss after configured duration
    this.autoDismissTimer = setTimeout(() => {
      this.dismiss();
    }, ShareConstants.RECEIVE_NOTIFICATION_DURATION);
  }

  aboutToDisappear(): void {
    if (this.autoDismissTimer !== -1) {
      clearTimeout(this.autoDismissTimer);
      this.autoDismissTimer = -1;
    }
  }

  parseData(): void {
    if (!this.receivedData || this.receivedData.length === 0) {
      return;
    }
    try {
      const parsed = JSON.parse(this.receivedData) as Record<string, Object>;
      const preview = new ReceivePayloadPreview();

      // Detect payload type by checking for known fields
      if (parsed['productName'] !== undefined) {
        // Product share payload
        preview.type = 'product';
        preview.title = parsed['productName'] as string;
        preview.subtitle = '¥' + (parsed['price'] as string ?? '');
        preview.detail = parsed['storeName'] as string ?? '';
      } else if (parsed['favoritesCount'] !== undefined) {
        // App data share payload
        preview.type = 'appData';
        preview.title = '应用数据';
        preview.subtitle = (parsed['favoritesCount'] as number ?? 0) + '个收藏, ' +
          (parsed['historyCount'] as number ?? 0) + '条浏览记录';
        preview.detail = '来自附近设备';
      } else {
        preview.type = 'unknown';
        preview.title = '收到共享数据';
        preview.subtitle = this.receivedData.substring(0, 50);
        preview.detail = '';
      }

      this.parseResult = preview;
    } catch (e) {
      const preview = new ReceivePayloadPreview();
      preview.type = 'unknown';
      preview.title = '收到共享数据';
      preview.subtitle = this.receivedData.substring(0, 50);
      this.parseResult = preview;
    }
  }

  accept(): void {
    this.isAccepted = true;
    // Clear notification state after brief display
    setTimeout(() => {
      this.dismiss();
    }, 1000);
  }

  dismiss(): void {
    if (this.autoDismissTimer !== -1) {
      clearTimeout(this.autoDismissTimer);
      this.autoDismissTimer = -1;
    }
    this.isDismissed = true;
    AppStorage.setOrCreate(ShareConstants.RECEIVE_NOTIFICATION_KEY, false);
  }

  build() {
    if (this.isDismissed || !this.isVisible) {
      // Invisible placeholder — no rendering
      Stack() { }
    } else {
      Stack() {
        Column() {
          // Header with close button
          Row() {
            Text('📨 收到共享数据')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .layoutWeight(1)

            Image($r('sys.media.ohos_ic_public_close'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
              .onClick(() => {
                this.dismiss();
              })
          }
          .width(CommonConstants.FULL_PERCENT)
          .padding({ left: 16, right: 16, top: 12, bottom: 8 })

          // Payload preview
          if (this.parseResult) {
            Column() {
              // Status icon
              if (this.isAccepted) {
                Text('✓')
                  .fontSize(28)
                  .fontColor('#4CAF50')
                  .margin({ bottom: 8 })
                Text('已接收')
                  .fontSize(14)
                  .fontColor('#4CAF50')
              } else {
                Text(this.parseResult.type === 'product' ? '📦' :
                  (this.parseResult.type === 'appData' ? '📊' : '📋'))
                  .fontSize(28)
                  .margin({ bottom: 8 })

                Text(this.parseResult.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.White)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text(this.parseResult.subtitle)
                  .fontSize(14)
                  .fontColor('#B0BEC5')
                  .margin({ top: 4 })

                if (this.parseResult.detail.length > 0) {
                  Text(this.parseResult.detail)
                    .fontSize(12)
                    .fontColor('#78909C')
                    .margin({ top: 2 })
                }
              }
            }
            .alignItems(HorizontalAlign.Center)
            .width(CommonConstants.FULL_PERCENT)
            .padding({ top: 8, bottom: 12 })
          }

          // Action buttons
          if (!this.isAccepted) {
            Row() {
              Button('拒绝')
                .fontSize(14)
                .backgroundColor('#424242')
                .fontColor(Color.White)
                .layoutWeight(1)
                .borderRadius(20)
                .onClick(() => {
                  this.dismiss();
                })

              Button('接收')
                .fontSize(14)
                .backgroundColor('#1565C0')
                .fontColor(Color.White)
                .layoutWeight(1)
                .borderRadius(20)
                .margin({ left: 12 })
                .onClick(() => {
                  this.accept();
                })
            }
            .width(CommonConstants.FULL_PERCENT)
            .padding({ left: 16, right: 16, bottom: 12 })
          }
        }
        .width(CommonConstants.FULL_PERCENT)
        .backgroundColor('#1E1E1E')
        .borderRadius(16)
        .padding({ top: 4, bottom: 4 })
        .shadow({
          radius: 24,
          color: '#00000066',
          offsetX: 0,
          offsetY: 8
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, right: 16 })
      .position({ x: 0, y: 80 })
      .zIndex(1000)
      .transition(
        TransitionEffect.OPACITY
          .animation({ duration: 300, curve: Curve.EaseOut })
          .combine(TransitionEffect.translate({ y: -40 })
            .animation({ duration: 300, curve: Curve.EaseOut }))
      )
    }
  }
}

/**
 * Preview data extracted from the received payload for display.
 */
class ReceivePayloadPreview {
  type: string = '';
  title: string = '';
  subtitle: string = '';
  detail: string = '';
}
