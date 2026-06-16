/**
 * Product search view with real-time filtering and search history.
 */
import { BreakpointConstants, CommonConstants, CURRENT_PRODUCT_ID_KEY, resolveProductId, ResourceUtil, ToastUtil, ContinuationManager } from '@ohos/commons';
import { ClassifyConstants } from '../constants/ClassifyConstants';

@Component
export struct SearchView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State searchText: string = '';
  @State searchHistory: string[] = [];
  @State searchResults: SearchResultItem[] = [];
  @State showHistory: boolean = true;
  private continuationManager: ContinuationManager = ContinuationManager.getInstance();

  private allProducts: SearchResultItem[] = [
    new SearchResultItem('HUAWEI Mate 60 Pro', '￥6999', '手机', $r('app.media.flash_sale_product_1')),
    new SearchResultItem('HUAWEI Mate X5', '￥12999', '手机', $r('app.media.flash_sale_product_2')),
    new SearchResultItem('HUAWEI P60 Pro', '￥6988', '手机', $r('app.media.flash_sale_product_3')),
    new SearchResultItem('HUAWEI Mate 50 Pro', '￥4999', '手机', $r('app.media.flash_sale_product_4')),
    new SearchResultItem('HUAWEI MateBook X Pro', '￥10999', '笔记本', $r('app.media.welfare_product_1')),
    new SearchResultItem('HUAWEI MatePad Air', '￥2599', '平板', $r('app.media.welfare_product_3')),
    new SearchResultItem('HUAWEI Watch GT 4', '￥1488', '穿戴', $r('app.media.welfare_product_4')),
    new SearchResultItem('HUAWEI FreeBuds Pro 3', '￥1499', '耳机', $r('app.media.welfare_product_5')),
    new SearchResultItem('MateBook E Go', '￥4899', '笔记本', $r('app.media.welfare_product_6')),
    new SearchResultItem('HUAWEI Mate 60', '￥5999', '手机', $r('app.media.welfare_product_2')),
    new SearchResultItem('Sound X NEW', '￥2499', '影音', $r('app.media.welfare_product_7')),
    new SearchResultItem('HUAWEI MateBook 14s', '￥8399', '笔记本', $r('app.media.welfare_product_8')),
  ];

  aboutToAppear(): void {
    // Track search page for continuation (自由流转)
    this.continuationManager.updateState(
      this.continuationManager.getCurrentTabIndex(), 'SearchView');
    let history = AppStorage.get<string[]>('searchHistory');
    if (history) {
      this.searchHistory = history;
    }

    // Restore search keyword from continuation (自由流转)
    let continuationKeyword = AppStorage.get<string>('continuationSearchKeyword');
    if (continuationKeyword && continuationKeyword.length > 0) {
      this.searchText = continuationKeyword;
      this.onSearch(continuationKeyword);
      // Clear the signal after consuming
      AppStorage.setOrCreate('continuationSearchKeyword', '');
    }
  }

  saveSearchHistory(keyword: string): void {
    if (keyword.trim().length === 0) {
      return;
    }
    let filtered: string[] = [];
    for (let i = 0; i < this.searchHistory.length; i++) {
      if (this.searchHistory[i] !== keyword) {
        filtered.push(this.searchHistory[i]);
      }
    }
    filtered.unshift(keyword);
    if (filtered.length > 10) {
      filtered = filtered.slice(0, 10);
    }
    this.searchHistory = filtered;
    AppStorage.setOrCreate('searchHistory', filtered);
  }

  clearHistory(): void {
    this.searchHistory = [];
    AppStorage.setOrCreate('searchHistory', []);
  }

  onSearch(keyword: string): void {
    if (keyword.trim().length === 0) {
      this.showHistory = true;
      this.searchResults = [];
      return;
    }
    this.showHistory = false;
    this.saveSearchHistory(keyword);
    // Track search keyword for continuation (自由流转)
    this.continuationManager.updateState(
      this.continuationManager.getCurrentTabIndex(), 'SearchView', '', false, keyword);
    let lowerKeyword = keyword.toLowerCase();
    let results: SearchResultItem[] = [];
    for (let i = 0; i < this.allProducts.length; i++) {
      let item = this.allProducts[i];
      if (item.name.toLowerCase().indexOf(lowerKeyword) >= 0 ||
        item.category.toLowerCase().indexOf(lowerKeyword) >= 0) {
        results.push(item);
      }
    }
    this.searchResults = results;
  }

  onHistoryClick(keyword: string): void {
    this.searchText = keyword;
    this.onSearch(keyword);
  }

  build() {
    NavDestination() {
      Column() {
        // Search input bar
        Row() {
          Image($r('app.media.ic_public_back'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ right: 12 })
            .onClick(() => {
              this.pageInfos.pop();
            })

          TextInput({ text: this.searchText, placeholder: '搜索商品' })
            .placeholderFont({ size: 14 })
            .placeholderColor('#999999')
            .height(36)
            .fontSize(14)
            .layoutWeight(1)
            .backgroundColor('#F1F3F5')
            .borderRadius(18)
            .padding({ left: 16, right: 16 })
            .onChange((value: string) => {
              this.searchText = value;
              this.onSearch(value);
            })

          Text('搜索')
            .fontSize(14)
            .fontColor('#CF0A2C')
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .margin({ left: 12 })
            .onClick(() => {
              this.onSearch(this.searchText);
            })
        }
        .width(CommonConstants.FULL_PERCENT)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        if (this.showHistory && this.searchText.length === 0) {
          // Search history
          Column() {
            Row() {
              Text('搜索历史')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('清空')
                .fontSize(12)
                .fontColor('#999999')
                .onClick(() => {
                  this.clearHistory();
                })
            }
            .width(CommonConstants.FULL_PERCENT)
            .padding({ left: 16, right: 16 })

            if (this.searchHistory.length === 0) {
              Text('暂无搜索历史')
                .fontSize(14)
                .fontColor('#999999')
                .width(CommonConstants.FULL_PERCENT)
                .textAlign(TextAlign.Center)
                .margin({ top: 48 })
            } else {
              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.searchHistory, (item: string) => {
                  Text(item)
                    .fontSize(12)
                    .fontColor('#666666')
                    .backgroundColor('#F1F3F5')
                    .borderRadius(16)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                    .onClick(() => {
                      this.onHistoryClick(item);
                    })
                    .flexShrink(0)
                }, (item: string) => item)
              }
              .width(CommonConstants.FULL_PERCENT)
              .padding({ left: 16, right: 16, top: 12 })
            }
          }
          .width(CommonConstants.FULL_PERCENT)
          .margin({ top: 8 })
        }

        // Hot search
        if (this.showHistory && this.searchText.length === 0) {
          Column() {
            Text('热门搜索')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width(CommonConstants.FULL_PERCENT)
              .padding({ left: 16, right: 16 })
              .margin({ top: 24 })

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(['Mate 60 Pro', 'Mate X5', 'MateBook', 'FreeBuds', 'Watch GT'], (item: string) => {
                Text(item)
                  .fontSize(12)
                  .fontColor('#CF0A2C')
                  .backgroundColor('#FFF0F0')
                  .borderRadius(16)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .margin({ right: 8, bottom: 8 })
                  .onClick(() => {
                    this.onHistoryClick(item);
                  })
                  .flexShrink(0)
              }, (item: string) => item)
            }
            .width(CommonConstants.FULL_PERCENT)
            .padding({ left: 16, right: 16, top: 12 })
          }
          .width(CommonConstants.FULL_PERCENT)
        }

        // Search results
        if (!this.showHistory && this.searchResults.length > 0) {
          Text(`找到 ${this.searchResults.length} 个相关商品`)
            .fontSize(13)
            .fontColor('#999999')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .width(CommonConstants.FULL_PERCENT)

          List() {
            ForEach(this.searchResults, (item: SearchResultItem) => {
              ListItem() {
                Row() {
                  Image(item.image)
                    .width(72)
                    .height(72)
                    .borderRadius(8)

                  Column() {
                    Text(item.name)
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    Text(item.category)
                      .fontSize(12)
                      .fontColor('#999999')
                      .margin({ top: 4 })

                    Text(item.price)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#CF0A2C')
                      .margin({ top: 6 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 12 })
                  .layoutWeight(1)
                }
                .width(CommonConstants.FULL_PERCENT)
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .onClick(() => {
                  ToastUtil.show('查看「' + item.name + '」详情');
                  AppStorage.setOrCreate(CURRENT_PRODUCT_ID_KEY, resolveProductId(item.name));
                  this.pageInfos.pushPathByName(ClassifyConstants.PAGE_INFO_LIST[2], undefined);
                })
              }
            }, (item: SearchResultItem) => item.name)
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .divider({ strokeWidth: 0.5 })
        }

        if (!this.showHistory && this.searchText.length > 0 && this.searchResults.length === 0) {
          Column() {
            Image($r('app.media.ic_public_search'))
              .width(64)
              .height(64)
              .opacity(0.3)
              .margin({ top: 80 })
            Text('未找到相关商品')
              .fontSize(14)
              .fontColor('#999999')
              .margin({ top: 12 })
          }
          .width(CommonConstants.FULL_PERCENT)
        }

        if (this.showHistory) {
          Blank()
        }
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
  }
}

class SearchResultItem {
  name: string;
  price: string;
  category: string;
  image: Resource;

  constructor(name: string, price: string, category: string, image: Resource) {
    this.name = name;
    this.price = price;
    this.category = category;
    this.image = image;
  }
}
