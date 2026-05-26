/**
 * Mine/Personal page with favorites, browsing history, and user profile.
 * This replaces the previously empty "我的" tab.
 */
import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';

@Component
export struct MineContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @State favorites: FavoriteItem[] = [];
  @State browsingHistory: BrowsingHistoryItem[] = [];
  @State activeTab: number = 0;
  private tabTitles: string[] = ['我的收藏', '浏览历史'];

  aboutToAppear(): void {
    let favs = AppStorage.get<FavoriteItem[]>('favorites');
    if (favs) {
      this.favorites = favs;
    }
    let history = AppStorage.get<BrowsingHistoryItem[]>('browsingHistory');
    if (history) {
      this.browsingHistory = history;
    }
    // Seed some sample browsing history if empty
    if (this.browsingHistory.length === 0) {
      this.browsingHistory = [
        new BrowsingHistoryItem('HUAWEI Mate 60 Pro', '￥6999',
          $r('app.media.flash_sale_product_1'), '今天 14:30'),
        new BrowsingHistoryItem('HUAWEI Mate X5', '￥12999',
          $r('app.media.flash_sale_product_2'), '今天 10:15'),
        new BrowsingHistoryItem('HUAWEI MateBook X Pro', '￥10999',
          $r('app.media.welfare_product_1'), '昨天 16:42'),
      ];
      AppStorage.setOrCreate('browsingHistory', this.browsingHistory);
    }
    // Seed some sample favorites if empty
    if (this.favorites.length === 0) {
      this.favorites = [
        new FavoriteItem('HUAWEI Mate X5 幻影紫', '￥12999', '华为商城',
          $r('app.media.flash_sale_product_2'), '￥150'),
        new FavoriteItem('HUAWEI Mate 60 Pro', '￥6999', '京东',
          $r('app.media.flash_sale_product_1'), '￥100'),
      ];
      AppStorage.setOrCreate('favorites', this.favorites);
    }
  }

  removeFavorite(item: FavoriteItem): void {
    let newFavs: FavoriteItem[] = [];
    for (let i = 0; i < this.favorites.length; i++) {
      if (this.favorites[i].name !== item.name) {
        newFavs.push(this.favorites[i]);
      }
    }
    this.favorites = newFavs;
    AppStorage.setOrCreate('favorites', this.favorites);
  }

  clearHistory(): void {
    this.browsingHistory = [];
    AppStorage.setOrCreate('browsingHistory', []);
  }

  @Builder
  UserProfileHeader() {
    Row() {
      Image($r('app.media.user_profile'))
        .width(56)
        .height(56)
        .borderRadius(28)

      Column() {
        Text('华为用户')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text('普通会员')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 12 })

      Blank()

      Text('编辑资料')
        .fontSize(12)
        .fontColor('#CF0A2C')
        .border({ width: 1, color: '#CF0A2C', radius: 16 })
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ left: 16, right: 16, top: 16 })
  }

  @Builder
  StatsRow() {
    Row() {
      Column() {
        Text(this.favorites.length.toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('收藏')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Column() {
        Text(this.browsingHistory.length.toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('足迹')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Column() {
        Text('0')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('订单')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Column() {
        Text('0')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('优惠券')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
    }
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding({ top: 16, bottom: 16 })
    .margin({ left: 16, right: 16, top: 16 })
  }

  @Builder
  MenuEntry(icon: Resource, title: string) {
    Row() {
      Image(icon)
        .width(20)
        .height(20)
      Text(title)
        .fontSize(14)
        .margin({ left: 10 })
      Blank()
      Image(ResourceUtil.getArrowRight())
        .width(12)
        .height(12)
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
  }

  @Builder
  TabBar() {
    Row() {
      ForEach(this.tabTitles, (item: string, index: number) => {
        Column() {
          Text(item)
            .fontSize(15)
            .fontWeight(this.activeTab === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.activeTab === index ? '#CF0A2C' : '#333333')
          if (this.activeTab === index) {
            Divider()
              .width(24)
              .height(2)
              .color('#CF0A2C')
              .margin({ top: 6 })
          }
        }
        .padding({ left: 24, right: 24 })
        .onClick(() => {
          this.activeTab = index;
        })
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }, (item: string, index: number) => item + index)
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ top: 14, bottom: 14 })
    .margin({ left: 16, right: 16, top: 16 })
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 12, topRight: 12 })
  }

  @Builder
  FavoritesList() {
    if (this.favorites.length === 0) {
      Column() {
        Image($r('app.media.tab_mine'))
          .width(48)
          .height(48)
          .opacity(0.3)
          .margin({ top: 48 })
        Text('暂无收藏商品')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 12 })
        Text('浏览商品时点击收藏按钮即可添加')
          .fontSize(12)
          .fontColor('#999999')
          .opacity(0.6)
          .margin({ top: 6 })
      }
      .width(CommonConstants.FULL_PERCENT)
    } else {
      List() {
        ForEach(this.favorites, (item: FavoriteItem, index: number) => {
          ListItem() {
            Row() {
              Image(item.image)
                .width(72)
                .height(72)
                .borderRadius(8)

              Column() {
                Text(item.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text(item.platform)
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ top: 4 })

                Row() {
                  Text(item.price)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#CF0A2C')

                  if (item.priceDrop.length > 0) {
                    Text('已降' + item.priceDrop)
                      .fontSize(10)
                      .fontColor('#E3393C')
                      .backgroundColor('#FFF0F0')
                      .borderRadius(4)
                      .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                      .margin({ left: 8 })
                  }
                }
                .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
              .layoutWeight(1)

              Image($r('app.media.icon_close_1'))
                .width(16)
                .height(16)
                .onClick(() => {
                  this.removeFavorite(item);
                })
            }
            .width(CommonConstants.FULL_PERCENT)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          }
        }, (item: FavoriteItem) => item.name + item.platform)
      }
      .scrollBar(BarState.Off)
      .divider({ strokeWidth: 0.5 })
    }
  }

  @Builder
  BrowsingHistoryList() {
    if (this.browsingHistory.length === 0) {
      Column() {
        Image($r('app.media.ic_public_scan'))
          .width(48)
          .height(48)
          .opacity(0.3)
          .margin({ top: 48 })
        Text('暂无浏览记录')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 12 })
        Text('浏览过的商品将会出现在这里')
          .fontSize(12)
          .fontColor('#999999')
          .opacity(0.6)
          .margin({ top: 6 })
      }
      .width(CommonConstants.FULL_PERCENT)
    } else {
      Column() {
        Row() {
          Text('共' + this.browsingHistory.length + '条记录')
            .fontSize(12)
            .fontColor('#999999')
          Blank()
          Text('清空')
            .fontSize(12)
            .fontColor('#CF0A2C')
            .onClick(() => {
              this.clearHistory();
            })
        }
        .width(CommonConstants.FULL_PERCENT)
        .padding({ left: 16, right: 16, top: 12, bottom: 8 })

        List() {
          ForEach(this.browsingHistory, (item: BrowsingHistoryItem) => {
            ListItem() {
              Row() {
                Image(item.image)
                  .width(72)
                  .height(72)
                  .borderRadius(8)

                Column() {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(item.price)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#CF0A2C')
                    .margin({ top: 4 })
                  Text(item.viewTime)
                    .fontSize(11)
                    .fontColor('#999999')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 12 })
                .layoutWeight(1)
              }
              .width(CommonConstants.FULL_PERCENT)
              .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            }
          }, (item: BrowsingHistoryItem) => item.name + item.viewTime)
        }
        .scrollBar(BarState.Off)
      }
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.UserProfileHeader()
          this.StatsRow()

          // Menu entries
          Column() {
            this.MenuEntry($r('app.media.icon_order'), '我的订单')
            Divider().color('#F1F3F5').margin({ left: 16 })
            this.MenuEntry($r('app.media.icon_pay'), '收货地址')
            Divider().color('#F1F3F5').margin({ left: 16 })
            this.MenuEntry($r('app.media.icon_order'), '优惠券')
          }
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ left: 16, right: 16, top: 16 })

          // Tabs for favorites and history
          Column() {
            this.TabBar()

            Column() {
              if (this.activeTab === 0) {
                this.FavoritesList()
              } else {
                this.BrowsingHistoryList()
              }
            }
            .backgroundColor(Color.White)
          }
          .margin({ left: 16, right: 16, top: 16 })

          Blank()
        }
        .padding({
          top: deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0] ? this.topRectHeight : 0,
          bottom: 24
        })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width(CommonConstants.FULL_PERCENT)
    }
    .backgroundColor('#F1F3F5')
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}

export class FavoriteItem {
  name: string;
  price: string;
  platform: string;
  image: Resource;
  priceDrop: string;

  constructor(name: string, price: string, platform: string, image: Resource, priceDrop: string = '') {
    this.name = name;
    this.price = price;
    this.platform = platform;
    this.image = image;
    this.priceDrop = priceDrop;
  }
}

export class BrowsingHistoryItem {
  name: string;
  price: string;
  image: Resource;
  viewTime: string;

  constructor(name: string, price: string, image: Resource, viewTime: string) {
    this.name = name;
    this.price = price;
    this.image = image;
    this.viewTime = viewTime;
  }
}
