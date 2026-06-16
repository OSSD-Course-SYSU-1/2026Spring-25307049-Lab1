/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { BreakpointConstants, CommonConstants, ToastUtil } from '@ohos/commons';
import { ShopCarIcon, ShopCarModel } from '../viewmodel/ShopCarViewModel';

@Component
export struct ShopBagHeader {
  private shopCarIcons: ShopCarIcon[] = new ShopCarModel(this.getUIContext().getHostContext()!).getShopCarIconList();
  @Link isMoreDetail: boolean;

  build() {
    Row() {
      Text($r('app.string.pocket_baby'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .fontSize($r('app.float.bag_name_font_size'))
        .lineHeight($r('app.float.bag_name_line_height'))
      Blank()
      ShopBagIconView({ iconResource: this.shopCarIcons[0].getIcon(), iconName: this.shopCarIcons[0].getName(),
        onItemClick: () => { ToastUtil.showFeaturePending('客服'); } })
      ShopBagIconView({ iconResource: this.shopCarIcons[1].getIcon(), iconName: this.shopCarIcons[1].getName(),
        onItemClick: () => { ToastUtil.show('进入直播购物'); } })
      ShopBagIconView({ iconResource: this.shopCarIcons[2].getIcon(), iconName: this.shopCarIcons[2].getName(),
        onItemClick: () => { ToastUtil.showFeaturePending('购物车管理'); } })

      Image($r('app.media.icon_close_2'))
        .width($r('app.float.bag_close_icon_size'))
        .aspectRatio(1)
        .onClick(() => {
          this.isMoreDetail = false;
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.shop_tab_height'))

  }
}

@Component
struct ShopBagIconView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  public iconResource: Resource = $r('app.media.icon_bag');
  public iconName: string = '';
  onItemClick?: () => void;

  build() {
    Column() {
      Image(this.iconResource)
        .width($r('app.float.bag_icon_size'))
        .aspectRatio(1)
        .margin({
          bottom: $r('app.float.bag_icon_margin_bottom')
        })
      Text(this.iconName)
        .fontSize($r('app.float.bag_icon_font_size'))
        .lineHeight($r('app.float.bag_icon_line_height'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
    }
    .justifyContent(FlexAlign.End)
    .width($r('app.float.bag_icon_width'))
    .margin({
      right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bag_icon_margin_lg') : $r('app.float.bag_icon_margin_md_sm')
    })
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick();
      }
    })
  }
}