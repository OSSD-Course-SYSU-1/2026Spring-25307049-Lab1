/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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
import { DURATION_0, DURATION_300, LAYOUT_WEIGHT_1, TAB_INDEX_TWO } from '../../../constants/CommonConstants';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { BottomTabModel } from './model/BottomTabModel';
import { LengthMetrics } from '@kit.ArkUI';
import {
  PADDING_16VP,
  PADDING_24VP,
  PADDING_32VP,
  PADDING_4VP,
  PADDING_6VP,
  PADDING_8VP
} from '../../../designtoken/Padding';
import {
  SIZE_NUM_24,
  SIZE_NUM_28,
  SIZE_NUM_36,
  SIZE_NUM_40,
  SIZE_NUM_56,
  SIZE_NUM_76,
  SIZE_NUM_96,
  SIZE_PERCENT_100
} from '../../../designtoken/Size';
import { WindowUtil } from '../../../utils/WindowUtil';
import { DividerMode, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';

@Builder
export function RudderStyleTabBarBuilder() {
  RudderStyleTabBar();
}

@ComponentV2
struct RudderStyleTabBar {
  @Local tabArray: Array<BottomTabModel> = [];
  @Local currentIndex: number = 0;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private controller: HdsTabsController = new HdsTabsController();
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();
  private isLayoutFullScreen: boolean = false;

  private get currentWidthBreakpoint(): string {
    return this.breakpointModel.currentWidthBreakpoint;
  }

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case 'xs':
      case 'sm':
      case 'md':
        if (this.isLayoutFullScreen) {
          this.isLayoutFullScreen = false;
          this.winUtil?.setFullScreen(false);
        }
        break;
      case 'lg':
      case 'xl':
        if (!this.isLayoutFullScreen) {
          this.isLayoutFullScreen = true;
          this.winUtil?.setFullScreen(true);
        }
        break;
      default:
        this.isLayoutFullScreen = false;
        this.winUtil?.setFullScreen(false);
        break;
    }
  }

  aboutToAppear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    this.tabArray = [
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab1'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab2'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), '', true),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab3'),
      new BottomTabModel($r('sys.symbol.person_crop_circle_fill_1'), 'Tab4')
    ];
    if (['lg', 'xl'].includes(this.currentWidthBreakpoint) && !this.isLayoutFullScreen) {
      this.isLayoutFullScreen = true;
      this.winUtil?.setFullScreen(true);
    }
  }

  aboutToDisappear(): void {
    this.isLayoutFullScreen = false;
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  tabContentBuilder(name: ResourceStr) {
    Column() {
      this.customTitleBar();
      Row() {
        Text(name)
          .fontColor($r('sys.color.font_emphasize'))
          .fontSize($r('sys.float.Title_M'))
          .fontWeight(FontWeight.Regular)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .layoutWeight(LAYOUT_WEIGHT_1)
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_PERCENT_100)
    .backgroundColor($r('sys.color.background_primary'))
  }

  @Builder
  customTitleBar() {
    if (this.currentWidthBreakpoint === 'lg') {
      Row() {
        this.customNavDestinationTitleV2();
      }
      .width(SIZE_PERCENT_100)
      .padding({
        left: PADDING_24VP,
        right: PADDING_24VP
      })
      .alignItems(VerticalAlign.Top)
    }
  }

  @Builder
  tabBarBuilder(imgSrc: Resource, title: ResourceStr, middleMode: boolean, index: number) {
    Column() {
      if (index === TAB_INDEX_TWO) {
        SymbolGlyph($r('sys.symbol.plus_circle_fill'))
          .fontSize($r('sys.float.Display_L'))
          .fontColor([$r('sys.color.icon_emphasize')])
      } else {
        SymbolGlyph(imgSrc)
          .fontSize($r('sys.float.Title_M'))
          .fontColor(this.currentIndex === index ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_tertiary')])
      }

      if (!middleMode) {
        Text(title)
          .fontSize($r('sys.float.Caption_M'))
          .margin({ top: PADDING_6VP })
          .fontColor(this.currentIndex === index ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
      }
    }
    .width(this.currentWidthBreakpoint !== 'lg' ? SIZE_PERCENT_100 : SIZE_NUM_96)
    .height(this.currentWidthBreakpoint !== 'lg' ? SIZE_NUM_76 : SIZE_PERCENT_100)
    .backgroundColor($r('app.color.gray_08'))
    .justifyContent(this.currentWidthBreakpoint !== 'lg' ? FlexAlign.Start : FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(this.currentWidthBreakpoint !== 'lg' ? { top: PADDING_4VP } : undefined)
    .onClick(() => {
      if (index !== TAB_INDEX_TWO) {
        this.currentIndex = index;
        this.controller?.changeIndex(index);
      }
    })
  }

  @Builder
  customNavDestinationTitleV2() {
    Row() {
      Stack() {
        Circle({ width: SIZE_NUM_40, height: SIZE_NUM_40 })
          .fill($r('app.color.back_button_color'))

        Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
          .height(SIZE_NUM_24)
          .width(SIZE_NUM_24)
          .fillColor($r('sys.color.font_primary'))
      }
      .height(SIZE_PERCENT_100)
      .onClick(this.handleBackNavigation)

      this.customNavDestinationTitle()
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .margin({ top: SIZE_NUM_36 })
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text($r('app.string.bottom_tab_bar_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.custom_tab_style_label'))
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: PADDING_8VP })
  }

  build() {
    NavDestination() {
      Column() {
        Stack({
          alignContent: this.currentWidthBreakpoint !== 'lg' ? Alignment.BottomStart : Alignment.Start
        }) {
          HdsTabs({ controller: this.controller }) {
            ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
              if (index === TAB_INDEX_TWO) {
                TabContent()
                  .backgroundColor($r('sys.color.background_primary'))
              } else {
                TabContent() {
                  this.tabContentBuilder(item.title)
                }
                .backgroundColor($r('sys.color.background_primary'))
              }
            }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
          }
          .barPosition(this.currentWidthBreakpoint !== 'lg' ? BarPosition.End : BarPosition.Start)
          .vertical(this.currentWidthBreakpoint !== 'lg' ? false : true)
          .scrollable(false)
          .animationDuration(this.currentWidthBreakpoint !== 'lg' ? DURATION_300 : DURATION_0)
          .divider({ mode: DividerMode.NONE })

          Flex({
            direction: this.currentWidthBreakpoint !== 'lg' ? FlexDirection.Row : FlexDirection.Column
          }) {
            ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
              this.tabBarBuilder(item.imgSrc, item.title, item.middleMode, index)
            }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
          }
          .offset(this.currentWidthBreakpoint !== 'lg' ? { y: SIZE_NUM_28 } : undefined)
        }
      }
      .height(SIZE_PERCENT_100)
    }
    .hideTitleBar(this.currentWidthBreakpoint !== 'lg' ? false : true)
    .title(this.customNavDestinationTitle(), {
      backgroundColor: $r('sys.color.background_primary'),
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_24VP),
        LengthMetrics.vp(PADDING_32VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_24VP),
        LengthMetrics.vp(PADDING_32VP))
    })
    .onBackPressed(() => {
      this.handleBackNavigation();
      return true;
    })
  }

  /**
   * Handles back navigation with full-screen state management.
   *
   * - Exits full-screen mode if currently active
   * - Pops current `NavDestination` from navigation stack
   */
  private handleBackNavigation = (): void => {
    if (this.isLayoutFullScreen) {
      this.isLayoutFullScreen = false;
      this.winUtil?.setFullScreen(false);
    }
    this.navPathStack.pop();
  };
}