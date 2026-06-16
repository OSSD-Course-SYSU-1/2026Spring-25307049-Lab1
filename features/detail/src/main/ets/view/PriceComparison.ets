/**
 * Multi-platform price comparison component.
 * Displays prices from different platforms (JD, Taobao, PDD, Suning) for comparison shopping.
 */
import { BreakpointConstants, CommonConstants, PlatformPriceEntry, ResourceUtil, ToastUtil } from '@ohos/commons';

@Component
export struct PriceComparison {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Prop pageBreakpoint: string;
  @Prop platformPrices: PlatformPriceEntry[] = [];

  private getLowestPriceIndex(prices: PlatformPriceEntry[]): number {
    let lowestIdx = 0;
    let lowestVal = Number.MAX_VALUE;
    for (let i = 0; i < prices.length; i++) {
      // Extract numeric value from price string like '￥12899'
      let numStr = prices[i].price.replace('￥', '').replace(',', '');
      let val = parseFloat(numStr);
      if (!isNaN(val) && val < lowestVal) {
        lowestVal = val;
        lowestIdx = i;
      }
    }
    return lowestIdx;
  }

  @Builder
  PlatformCard(item: PlatformPriceEntry, index: number, totalCount: number) {
    Column() {
      Row() {
        Text(item.platformName)
          .fontSize(16)
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor('#333333')
        Blank()
        if (index === this.getLowestPriceIndex(this.platformPrices)) {
          Text('最低价')
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor('#E3393C')
            .borderRadius(4)
            .padding({ left: 6, right: 6 })
        }
      }
      .width(CommonConstants.FULL_PERCENT)

      Row() {
        Text(item.price)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(index === this.getLowestPriceIndex(this.platformPrices) ? '#E3393C' : '#333333')
          .margin({ top: 8 })

        Blank()

        Text('去看看')
          .fontSize(12)
          .fontColor(index === this.getLowestPriceIndex(this.platformPrices) ? Color.White : '#CF0A2C')
          .backgroundColor(index === this.getLowestPriceIndex(this.platformPrices) ? '#E3393C' : '#FFF0F0')
          .borderRadius(12)
          .padding({ left: 16, right: 16, top: 4, bottom: 4 })
          .onClick(() => {
            ToastUtil.show('跳转到' + item.platformName + '（示意图）');
          })
      }
      .width(CommonConstants.FULL_PERCENT)
      .margin({ top: 4 })

      if (index < totalCount - 1) {
        Divider()
          .color('#F1F3F5')
          .margin({ top: 8 })
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
  }

  build() {
    Column() {
      Row() {
        Text('多平台比价')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text('共' + this.platformPrices.length + '个平台')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 8 })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, right: 16, top: 12 })

      if (this.platformPrices.length > 0) {
        ForEach(this.platformPrices, (item: PlatformPriceEntry, index: number) => {
          this.PlatformCard(item, index, this.platformPrices.length)
        }, (item: PlatformPriceEntry, index: number) => item.platformName + index)
      }

      Row() {
        Text('温馨提示：价格来源于各平台公开信息，可能随促销活动变动，请以下单时实际价格为准。')
          .fontSize(10)
          .fontColor('#999999')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, right: 16, top: 8, bottom: 12 })
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({
      top: 12,
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .width(CommonConstants.FULL_PERCENT)
  }
}
