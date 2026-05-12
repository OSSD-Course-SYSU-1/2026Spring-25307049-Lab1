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
import {
  CALL_RECORDS_DATA,
  EMPTY_PAGE_NAME,
  INTEGER_1,
  LAYOUT_WEIGHT_1,
  PHONE_DIALER_PAGE_NAME
} from '../../../constants/CommonConstants';
import { SegmentButtonV2Items, SymbolGlyphModifier, TabSegmentButtonV2 } from '@kit.ArkUI';
import { WindowUtil } from '../../../utils/WindowUtil';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { DividerMode, HdsTabs, HdsTabsController } from '@hms.hds.hdsBaseComponent';
import {
  SIZE_NUM_24,
  SIZE_NUM_34,
  SIZE_NUM_40,
  SIZE_NUM_56,
  SIZE_NUM_58,
  SIZE_NUM_64,
  SIZE_NUM_81,
  SIZE_PERCENT_100,
  SIZE_PERCENT_50
} from '../../../designtoken/Size';
import { SPACE_4, SPACE_8 } from '../../../designtoken/Space';
import {
  PADDING_16VP,
  PADDING_24VP,
  PADDING_26VP,
  PADDING_42VP,
  PADDING_50VP,
  PADDING_8VP
} from '../../../designtoken/Padding';
import { CommonUtils } from '../../../utils/CommonUtils';

@Builder
export function SplitViewLayoutTabBarBuilder() {
  SplitViewLayoutTabBar()
}

@ComponentV2
struct SplitViewLayoutTabBar {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local normalSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.phone_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.phone_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_2_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_2_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.star_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local textItems: SegmentButtonV2Items = new SegmentButtonV2Items([
    { text: $r('app.string.all_phone_label') },
    { text: $r('app.string.missed_phone_label') }
  ]);
  // index of the selected segment
  @Local textSelectedIndex: number = 0;
  // selectedIndex controls the text color switching inside the custom TabBar
  @Local selectedIndex: number = 0;
  // currentIndex controls which tab page is displayed in the TabContent
  @Local currentIndex: number = 0;
  // navigation bar height
  @Local navigationBarHeight: Length | undefined = undefined;
  // status bar height
  @Local statusBarHeight: Length | undefined = undefined;
  private controller: HdsTabsController = new HdsTabsController();
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();
  private secondNavPathStack: NavPathStack = new NavPathStack();
  // the main window layout or the child window layout is immersive or not
  private isLayoutFullScreen: boolean = false;

  private get currentWidthBreakpoint(): string {
    return this.breakpointModel.currentWidthBreakpoint;
  }

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case 'xs':
      case 'sm':
        if (this.secondNavPathStack.size() > 0) {
          this.secondNavPathStack.pop(false);
        }
        break;
      case 'md':
      case 'lg':
      case 'xl':
        if (this.secondNavPathStack.size() === 0) {
          this.secondNavPathStack.pushPath({ name: PHONE_DIALER_PAGE_NAME }, false);
        }
        break;
      default:
        break;
    }
  }

  aboutToAppear(): void {
    if (['md', 'lg'].includes(this.currentWidthBreakpoint)) {
      this.secondNavPathStack.pushPath({ name: PHONE_DIALER_PAGE_NAME }, false);
    }
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    if (!this.isLayoutFullScreen) {
      this.isLayoutFullScreen = true;
      this.winUtil?.setFullScreen(true);
    }
    if (this.isLayoutFullScreen) {
      this.statusBarHeight = 32;
      this.navigationBarHeight = 28;
    }
  }

  aboutToDisappear(): void {
    this.isLayoutFullScreen = false;
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  listBuilder() {
    List() {
      Repeat(CALL_RECORDS_DATA)
        .each((itemWrap) => {
          ListItem() {
            Row() {
              Column() {
                Row({ space: SPACE_8 }) {
                  Column() {
                    SymbolGlyph($r('sys.symbol.phone_arrow_up_right_fill'))
                      .fontSize($r('sys.float.Subtitle_L'))
                      .fontColor([$r('sys.color.font_tertiary')])
                  }
                  .justifyContent(FlexAlign.Start)
                  .height(SIZE_PERCENT_100)
                  .padding({ top: PADDING_16VP })

                  Column() {
                    Text(itemWrap.item.title)
                      .fontSize($r('sys.float.Subtitle_L'))
                      .fontColor($r('sys.color.font_primary'))
                      .fontWeight(FontWeight.Regular)

                    Text(itemWrap.item.subTitle)
                      .fontSize($r('sys.float.Body_M'))
                      .fontColor($r('sys.color.font_secondary'))
                      .fontWeight(FontWeight.Regular)
                  }
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Start)
                }
              }

              Row({ space: SPACE_4 }) {
                Text(itemWrap.item.callTime)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor($r('sys.color.font_secondary'))
                  .fontWeight(FontWeight.Regular)

                SymbolGlyph($r('sys.symbol.info_circle'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .layoutWeight(LAYOUT_WEIGHT_1)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Center)
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_64)
          }
          .padding({
            left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
            right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
          })
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor($r('app.color.list_item_pressed_color'))
            }
          })
        })
        .key((item) => JSON.stringify(item))
    }
    .width(SIZE_PERCENT_100)
    .height('calc(100% - 40vp - 56vp - 81vp - 16vp)')
    .scrollBar(BarState.Off)
    .margin({ top: PADDING_16VP })
    .divider({
      strokeWidth: $r('sys.float.border_small'),
      color: $r('sys.color.comp_divider'),
      startMargin: this.breakpointModel.getValue(PADDING_42VP, PADDING_42VP, PADDING_50VP),
      endMargin: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
    })
  }

  @Builder
  customNavDestinationTitle() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
          .height(SIZE_NUM_24)
          .width(SIZE_NUM_24)
          .fillColor($r('sys.color.font_primary'))
      }
      .width(SIZE_NUM_40)
      .height(SIZE_NUM_40)
      .backgroundColor($r('app.color.back_button_color'))
      .onClick(this.handleBackNavigation)

      Row() {
        Column() {
          Text($r('app.string.bottom_tab_bar_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Bold)

          Text($r('app.string.split_view_sync_nav_label'))
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_M'))
            .maxLines(INTEGER_1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontWeight(FontWeight.Regular)
        }
        .height(SIZE_PERCENT_100)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(LAYOUT_WEIGHT_1)

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          SymbolGlyph($r('sys.symbol.dot_grid_2x2'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_primary')])
        }
        .width(SIZE_NUM_40)
        .height(SIZE_NUM_40)
        .backgroundColor($r('app.color.back_button_color'))
        .onClick(() => {
          CommonUtils.showToast('Dot button tapped.')
        })
      }
      .margin({ left: PADDING_8VP })
      .layoutWeight(LAYOUT_WEIGHT_1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .padding({
      left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
      right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
    })
  }

  @Builder
  tabContentBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.customNavDestinationTitle();

        Row() {
          Text($r('app.string.phone_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Bold)
        }
        .height(SIZE_NUM_81)
        .width(SIZE_PERCENT_100)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .padding({
          left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
          right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
        })

        Row() {
          TabSegmentButtonV2({
            items: this.textItems,
            selectedIndex: this.textSelectedIndex!!
          })
        }
        .width(SIZE_PERCENT_100)
        .padding({
          left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
          right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
        })

        if (this.textSelectedIndex === 0) {
          this.listBuilder()
        }
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .padding({ top: this.statusBarHeight })

      if (['xs', 'sm'].includes(this.currentWidthBreakpoint)) {
        this.dialButtonBuilder()
      }
    }
  }

  @Builder
  tabContentBuilderV2() {
    Column() {
      this.customNavDestinationTitle();
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_PERCENT_100)
    .padding({ top: this.statusBarHeight })
  }

  /**
   * Constructs the bottom green dial button
   */
  @Builder
  dialButtonBuilder() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      SymbolGlyph($r('sys.symbol.dial'))
        .fontSize(SIZE_NUM_34)
        .fontColor([$r('sys.color.font_on_primary')])
    }
    .width(SIZE_NUM_58)
    .height(SIZE_NUM_58)
    .backgroundColor($r('sys.color.confirm'))
    .margin({ bottom: PADDING_26VP })
    .onClick(() => {
      CommonUtils.showToast('Dial button tapped.');
    })
  }

  build() {
    NavDestination() {
      Navigation(this.secondNavPathStack) {
        HdsTabs({ controller: this.controller }) {
          TabContent() {
            this.tabContentBuilder()
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier1,
            selected: this.selectSymbolModifier1
          }, $r('app.string.phone_label')))

          TabContent() {
            this.tabContentBuilderV2();
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier2,
            selected: this.selectSymbolModifier2
          }, $r('app.string.contacts_label')))

          TabContent() {
            this.tabContentBuilderV2();
          }.tabBar(new BottomTabBarStyle({
            normal: this.normalSymbolModifier3,
            selected: this.selectSymbolModifier3
          }, $r('app.string.favorites_label')))
        }
        .barPosition(this.currentWidthBreakpoint !== 'lg' ? BarPosition.End : BarPosition.Start)
        .vertical(this.currentWidthBreakpoint !== 'lg' ? false : true)
        .barMode(BarMode.Fixed)
        .divider({ mode: this.currentWidthBreakpoint !== 'lg' ? DividerMode.NONE : DividerMode.VISIBLE })
        .scrollable(false)
        .padding({ bottom: this.currentWidthBreakpoint !== 'lg' ? this.navigationBarHeight : undefined })
        .onChange((index: number) => {
          this.selectedIndex = index;
          this.currentIndex = index;
          if (['md', 'lg'].includes(this.currentWidthBreakpoint)) {
            this.secondNavPathStack.replacePath({ name: index === 0 ? PHONE_DIALER_PAGE_NAME : EMPTY_PAGE_NAME },
              false);
          }
        })
        .onAnimationStart((index: number, targetIndex: number) => {
          if (index === targetIndex) {
            return;
          }
          this.selectedIndex = targetIndex;
        })
      }
      .navBarWidth(this.breakpointModel.getValue(SIZE_PERCENT_100, SIZE_PERCENT_50, this.getNavBarWidthRatio()))
      .hideTitleBar(true)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
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

  /**
   * Calculates the navigation bar width as a percentage of the total screen width.
   * The calculation includes both the tab bar width and a portion of the tab content area.
   *
   * @returns {string} The percentage value as a string with '%' suffix (e.g., '45.50%')
   */
  private getNavBarWidthRatio(): string {
    // Width of the tab bar in pixels
    const tabBarWidth: number = 276;
    // Current screen width in pixels
    const screenWidth: number = this.breakpointModel.windowWidth;
    // Width of the tab content area in pixels (40% of remaining space after tab bar)
    const tabContentWidth: number = (screenWidth - tabBarWidth) * 0.4;
    return `${(tabBarWidth + tabContentWidth) / screenWidth * 100}%`;
  }
}