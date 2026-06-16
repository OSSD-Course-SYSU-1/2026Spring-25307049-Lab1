import { BreakpointConstants, CommonConstants, ResourceUtil, ToastUtil } from '@ohos/commons';
import { deviceInfo } from '@kit.BasicServicesKit';
import { ShoppingCardFoot } from './ShoppingCardFoot';
import { ShoppingBagDiscounts } from './ShoppingBagDiscounts';
import { ShoppingBagListViewModel, ShoppingBagProduct } from '../viewmodel/ShoppingBagListViewModel';
import { ShoppingCardItem } from './ShoppingCardItem';
import { ShoppingBagConstants } from '../constants/ShoppingBagConstants';

@Component
export struct ShoppingBagContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  build() {
    Row() {
      ShoppingBagView()
      ShoppingBagDiscounts()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
  }
}

@Component
struct ShoppingBagView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @State allChecked: boolean = false;
  @State checkedStates: boolean[] = [false, false, false, false];
  private context: Context = this.getUIContext().getHostContext()!
  private shoppingBagList: ShoppingBagProduct[] = new ShoppingBagListViewModel(this.context).getShoppingBagItemData();

  getSelectedCount(): number {
    let count = 0;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (this.checkedStates[i]) {
        count++;
      }
    }
    return count;
  }

  getTotalPrice(): number {
    let total = 0;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (this.checkedStates[i]) {
        total += this.shoppingBagList[i].getPrice();
      }
    }
    return total;
  }

  toggleAll(): void {
    this.allChecked = !this.allChecked;
    for (let i = 0; i < this.checkedStates.length; i++) {
      this.checkedStates[i] = this.allChecked;
    }
  }

  onItemCheckChange(index: number): void {
    this.checkedStates[index] = !this.checkedStates[index];
    // Update allChecked state
    let allTrue = true;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (!this.checkedStates[i]) {
        allTrue = false;
        break;
      }
    }
    this.allChecked = allTrue;
  }

  build() {
    Column() {
      Column() {
        Row() {
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES(this.context)[0])
            .font({
              size: $r('app.float.bag_title_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
          Blank()
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES(this.context)[1])
            .font({
              size: $r('app.float.bag_name_font')
            })
            .opacity(CommonConstants.TEXT_OPACITY[2])
        }
        .height($r('app.float.bag_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        ShoppingBagCard({
          checkedStates: $checkedStates,
          allChecked: $allChecked,
          onItemCheckChange: (index: number) => { this.onItemCheckChange(index) },
          toggleAll: () => { this.toggleAll() }
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(1)
      .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.bag_col_margin') :
        this.topRectHeight })

      ShoppingCardFoot({
        selectedCount: this.getSelectedCount(),
        totalPrice: this.getTotalPrice(),
        onToggleAll: () => { this.toggleAll(); },
        onSettlement: () => {
          ToastUtil.show('确认结算 ' + this.getSelectedCount().toString() + ' 件商品，合计￥' + this.getTotalPrice().toString());
        }
      })
        .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
    }
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .layoutWeight(ShoppingBagConstants.SHOPPING_BAG_LAYOUT_WEIGHTS[0])
    .height(CommonConstants.FULL_PERCENT)
    .border({
      width: { right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : 0 },
      color: ResourceUtil.getCommonBorderColor()[1]
    })
  }
}

@Component
export struct DetailShoppingBagView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State allChecked: boolean = false;
  @State checkedStates: boolean[] = [false, false, false, false];
  public isMoreDetail: boolean = false;
  private context: Context = this.getUIContext().getHostContext()!
  private shoppingBagList: ShoppingBagProduct[] = new ShoppingBagListViewModel(this.context).getShoppingBagItemData();

  getSelectedCount(): number {
    let count = 0;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (this.checkedStates[i]) {
        count++;
      }
    }
    return count;
  }

  getTotalPrice(): number {
    let total = 0;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (this.checkedStates[i]) {
        total += this.shoppingBagList[i].getPrice();
      }
    }
    return total;
  }

  toggleAll(): void {
    this.allChecked = !this.allChecked;
    for (let i = 0; i < this.checkedStates.length; i++) {
      this.checkedStates[i] = this.allChecked;
    }
  }

  onItemCheckChange(index: number): void {
    this.checkedStates[index] = !this.checkedStates[index];
    let allTrue = true;
    for (let i = 0; i < this.checkedStates.length; i++) {
      if (!this.checkedStates[i]) {
        allTrue = false;
        break;
      }
    }
    this.allChecked = allTrue;
  }

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ right: $r('app.float.bag_back_margin') })
            .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM && this.isMoreDetail ?
              Visibility.Visible : Visibility.None)
            .onClick(() => {
              if (this.pageInfos !== undefined) {
                this.pageInfos.pop();
              }
            })
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES(this.context)[0])
            .font({
              size: $r('app.float.bag_title_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
          Blank()
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES(this.context)[1])
            .font({ size: $r('app.float.bag_name_font') })
            .opacity(CommonConstants.TEXT_OPACITY[2])
          Image($r('app.media.icon_close'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ left: $r('app.float.bag_close_margin') })
            .visibility(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM ? Visibility.Visible :
              Visibility.None)
            .onClick(() => {
              if (this.pageInfos !== undefined) {
                this.pageInfos.pop();
              }
            })
        }
        .height($r('app.float.bag_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        ShoppingBagCard({
          checkedStates: $checkedStates,
          allChecked: $allChecked,
          onItemCheckChange: (index: number) => { this.onItemCheckChange(index) },
          toggleAll: () => { this.toggleAll() }
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(1)
      .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.bag_col_margin') :
        this.topRectHeight })

      ShoppingCardFoot({
        selectedCount: this.getSelectedCount(),
        totalPrice: this.getTotalPrice(),
        onToggleAll: () => { this.toggleAll(); },
        onSettlement: () => {
          ToastUtil.show('确认结算 ' + this.getSelectedCount().toString() + ' 件商品，合计￥' + this.getTotalPrice().toString());
        }
      })
        .margin({ bottom: deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0] ?
          CommonConstants.BOTTOM_RECT_HEIGHT : 0 })
        .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && !this.isMoreDetail ?
          Visibility.None : Visibility.Visible)
    }
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .layoutWeight(ShoppingBagConstants.SHOPPING_BAG_LAYOUT_WEIGHTS[0])
    .height(CommonConstants.FULL_PERCENT)
    .border({
      width: { right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : 0 },
      color: ResourceUtil.getCommonBorderColor()[1]
    })
  }
}

@Component
struct ShoppingBagCard {
  @Link checkedStates: boolean[];
  @Link allChecked: boolean;
  onItemCheckChange: (index: number) => void = () => {};
  toggleAll: () => void = () => {};
  private context: Context = this.getUIContext().getHostContext()!
  private shoppingBagList: ShoppingBagProduct[] = new ShoppingBagListViewModel(this.context).getShoppingBagItemData();

  build() {
    Scroll() {
      Column() {
        Row() {
          Checkbox({ name: 'selectAll', group: 'cartGroup' })
            .select(this.allChecked)
            .selectedColor($r('app.color.classify_indicator_selected_color'))
            .width($r('app.float.check_box_size'))
            .height($r('app.float.check_box_size'))
            .margin({ right: $r('app.float.check_box_group_margin') })
            .border({ color: ResourceUtil.getCommonBorderColor()[2] })
            .onChange((value: boolean) => {
              this.toggleAll();
            })

          Image($r('app.media.shopping_card_logo'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ right: $r('app.float.bag_seller_logo_margin') })
            .border({
              radius: ResourceUtil.getCommonBorderRadius()[4],
              width: $r('app.float.bag_seller_logo_border_width'),
              color: ResourceUtil.getCommonBorderColor()[3]
            })

          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES(this.context)[2])
            .font({
              size: $r('app.float.bag_name_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
            .layoutWeight(1)
        }
        .height($r('app.float.bag_card_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        List() {
          ForEach(this.shoppingBagList, (item: ShoppingBagProduct, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Checkbox({ name: 'item_' + index, group: 'cartGroup' })
                    .select(this.checkedStates[index])
                    .selectedColor($r('app.color.classify_indicator_selected_color'))
                    .width($r('app.float.check_box_size'))
                    .height($r('app.float.check_box_size'))
                    .margin({
                      right: $r('app.float.bag_card_check_box_margin'),
                      left: 0
                    })
                    .border({
                      color: ResourceUtil.getCommonBorderColor()[2]
                    })
                    .shape(CheckBoxShape.ROUNDED_SQUARE)
                    .onChange((value: boolean) => {
                      this.onItemCheckChange(index);
                    })
                }
                .width($r('app.float.bag_card_check_col_width'))
                .padding({ top: $r('app.float.bag_card_check_col_padding') })
                .justifyContent(FlexAlign.Start)
                Column(){
                  ShoppingCardItem(item, false)
                }
                .layoutWeight(1)
              }
              .width(CommonConstants.FULL_PERCENT)
              .padding({
                top: $r('app.float.bag_card_row_padding'),
                bottom: $r('app.float.bag_card_row_padding')
              })
            }
          }, (item: ShoppingBagProduct) => item.getName())
        }
        .scrollBar(BarState.Off)
      }
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor(Color.White)
      .borderRadius(ResourceUtil.getCommonBorderRadius()[7])
      .padding($r('app.float.bag_card_col_padding'))
      .margin({ bottom: CommonConstants.BOTTOM_RECT_HEIGHT })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
    .width(CommonConstants.FULL_PERCENT)
  }
}
