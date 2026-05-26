/**
 * Multi-platform price comparison component.
 * Displays prices from different platforms (JD, Taobao, PDD, Suning) for comparison shopping.
 */
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';

@Component
export struct PriceComparison {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Prop pageBreakpoint: string;

  private platforms: PlatformPrice[] = [
    new PlatformPrice('京东', '￥12899', '#E3393C', 0),
    new PlatformPrice('淘宝', '￥12999', '#FF5000', 1),
    new PlatformPrice('拼多多', '￥12849', '#E02E24', 2),
    new PlatformPrice('苏宁', '￥13199', '#FFAA00', 3),
    new PlatformPrice('华为商城', '￥12999', '#CF0A2C', 4),
  ];

  @Builder
  PlatformCard(item: PlatformPrice, index: number) {
    Column() {
      Row() {
        Text(item.platformName)
          .fontSize(16)
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
          .fontColor('#333333')
        Blank()
        if (index === this.getLowestPriceIndex()) {
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
          .fontColor(index === this.getLowestPriceIndex() ? '#E3393C' : '#333333')
          .margin({ top: 8 })

        Blank()

        Text('去看看')
          .fontSize(12)
          .fontColor(index === this.getLowestPriceIndex() ? Color.White : '#CF0A2C')
          .backgroundColor(index === this.getLowestPriceIndex() ? '#E3393C' : '#FFF0F0')
          .borderRadius(12)
          .padding({ left: 16, right: 16, top: 4, bottom: 4 })
      }
      .width(CommonConstants.FULL_PERCENT)
      .margin({ top: 4 })

      if (index < this.platforms.length - 1) {
        Divider()
          .color('#F1F3F5')
          .margin({ top: 8 })
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
  }

  private getLowestPriceIndex(): number {
    return 2;
  }

  build() {
    Column() {
      Row() {
        Text('多平台比价')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text('共5个平台')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 8 })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, right: 16, top: 12 })

      ForEach(this.platforms, (item: PlatformPrice, index: number) => {
        this.PlatformCard(item, index)
      }, (item: PlatformPrice, index: number) => item.platformName + index)

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

class PlatformPrice {
  platformName: string;
  price: string;
  color: string;
  sortOrder: number;

  constructor(name: string, price: string, color: string, order: number) {
    this.platformName = name;
    this.price = price;
    this.color = color;
    this.sortOrder = order;
  }
}
