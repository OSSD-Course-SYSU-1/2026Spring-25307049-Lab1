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
import { HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { LengthMetrics, SymbolGlyphModifier, window } from '@kit.ArkUI';
import { DURATION_500, IMAGE_DETAIL_DATA, ImageInfo, TEXT_MAX_LINES_2 } from '../../../constants/CommonConstants';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { CommonUtils } from '../../../utils/CommonUtils';
import { SIZE_NUM_24, SIZE_NUM_76, SIZE_PERCENT_100 } from '../../../designtoken/Size';
import {
  PADDING_16VP,
  PADDING_24VP,
  PADDING_32VP,
  PADDING_48VP,
  PADDING_80VP,
  PADDING_8VP
} from '../../../designtoken/Padding';
import { SPACE_12, SPACE_8 } from '../../../designtoken/Space';
import { CORNER_RADIUS_16 } from '../../../designtoken/CornerRadius';
import { WindowUtil } from '../../../utils/WindowUtil';

@Builder
export function GradientBlurTabBarBuilder() {
  GradientBlurTabBar();
}

@ComponentV2
struct GradientBlurTabBar {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local currentGridColumn: string = BreakpointModel.getInstance().currentGridColumn;
  @Local normalSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.house_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier1: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.house_fill')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.auditorium')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier2: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.auditorium')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  @Local normalSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_crop_circle_fill_1')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_tertiary')]);
  @Local selectSymbolModifier3: SymbolGlyphModifier =
    new SymbolGlyphModifier($r('sys.symbol.person_crop_circle_fill_1')).fontSize($r('sys.float.Title_M'))
      .fontColor([$r('sys.color.icon_emphasize')]);
  private controller: HdsTabsController | undefined = undefined;
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();

  private get currentWidthBreakpoint(): string {
    return this.breakpointModel.currentWidthBreakpoint;
  }

  aboutToAppear(): void {
    this.controller = new HdsTabsController();
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    this.winUtil?.setMainWindowOrientation(window.Orientation.PORTRAIT);
  }

  aboutToDisappear(): void {
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
    this.winUtil?.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
  }

  @Monitor('breakpointModel.currentWidthBreakpoint')
  currentWidthBreakpointChange(monitor: IMonitor) {
    switch (monitor.value()?.now) {
      case 'xs':
      case 'sm':
        this.currentGridColumn = '1fr 1fr';
        break;
      case 'md':
        this.currentGridColumn = '1fr 1fr 1fr';
        break;
      case 'lg':
      case 'xl':
        this.currentGridColumn = '1fr 1fr 1fr 1fr';
        this.winUtil?.setMainWindowOrientation(window.Orientation.LANDSCAPE);
        break;
      default:
        this.currentGridColumn = '1fr 1fr';
        break;
    }
  }

  @Builder
  tabContentBuilder() {
    Column() {
      Row() {
        Text($r('app.string.more_playlist_recommendation_label'))
          .fontSize($r('sys.float.Subtitle_L'))
          .fontColor($r('sys.color.font_primary'))
          .lineHeight(SIZE_NUM_24)
          .fontWeight(FontWeight.Bold)
      }
      .width(SIZE_PERCENT_100)
      .padding({
        top: PADDING_16VP,
        bottom: PADDING_8VP
      })

      Grid() {
        Repeat(IMAGE_DETAIL_DATA)
          .each((itemWrap) => {
            GridItem() {
              Column({ space: SPACE_8 }) {
                Image(itemWrap.item.imgSrc)
                  .objectFit(ImageFit.Contain)
                  .width(SIZE_PERCENT_100)
                  .hoverEffect(HoverEffect.Scale)
                  .focusable(true)
                  .groupDefaultFocus(itemWrap.index === 0 ? true : false)
                  .draggable(false)
                  .borderRadius(CORNER_RADIUS_16)
                  .id(JSON.stringify(itemWrap.item))

                this.imageDescriptionBuilder(itemWrap.item.imgDescription)
              }
              .alignItems(HorizontalAlign.Start)
            }
          })
          .key((item: ImageInfo, index: number) => `${index}_${JSON.stringify(item)}`)
      }
      .editMode(false)
      .columnsTemplate(this.currentGridColumn)
      .width(SIZE_PERCENT_100)
      .rowsGap(SPACE_12)
      .columnsGap(SPACE_12)
      .scrollBar(BarState.Off)
      .padding({
        top: PADDING_8VP,
        bottom: PADDING_80VP
      })
      .margin({ bottom: PADDING_48VP })
      .gesture(PinchGesture({ fingers: 2 }).onActionUpdate((event: GestureEvent) => {
        if (event.scale > 1 && this.currentWidthBreakpoint !== 'sm') {
          if (this.currentWidthBreakpoint === 'md') {
            this.getUIContext().animateTo({
              duration: DURATION_500
            }, () => {
              this.currentGridColumn = '1fr 1fr 1fr';
            })
          } else {
            this.getUIContext().animateTo({
              duration: DURATION_500
            }, () => {
              this.currentGridColumn = '1fr 1fr 1fr 1fr';
            })
          }
        } else if (event.scale < 1 && this.currentWidthBreakpoint !== 'sm') {
          if (this.currentWidthBreakpoint === 'md') {
            this.getUIContext().animateTo({
              duration: DURATION_500
            }, () => {
              this.currentGridColumn = '1fr 1fr 1fr 1fr';
            })
          } else {
            this.getUIContext().animateTo({
              duration: DURATION_500
            }, () => {
              this.currentGridColumn = '1fr 1fr 1fr 1fr 1fr';
            })
          }
        } else {
          CommonUtils.showToast(`Two-finger operation is not supported`);
        }
      }))
    }
    .width(SIZE_PERCENT_100)
    .padding({
      left: this.breakpointModel.getValue(PADDING_16VP, PADDING_24VP, PADDING_32VP),
      right: this.breakpointModel.getValue(PADDING_16VP, PADDING_24VP, PADDING_32VP)
    })
  }

  @Builder
  imageDescriptionBuilder(des: ResourceStr) {
    Text(des)
      .fontColor($r('sys.color.font_primary'))
      .fontSize($r('sys.float.Body_M'))
      .fontWeight(FontWeight.Regular)
      .maxLines(TEXT_MAX_LINES_2)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text($r('app.string.bottom_tab_bar_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.gradient_blur_label'))
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
      HdsTabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          this.tabContentBuilder();
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier1,
          selected: this.selectSymbolModifier1
        }, $r('app.string.home_label')))

        TabContent() {
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier2,
          selected: this.selectSymbolModifier2
        }, $r('app.string.concert_hall_label')))

        TabContent() {
        }
        .tabBar(new BottomTabBarStyle({
          normal: this.normalSymbolModifier3,
          selected: this.selectSymbolModifier3
        }, $r('app.string.me_label')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .barOverlap(true)
      .barBackgroundStyle({
        maskColor: $r('sys.color.background_fourth'),
        maskHeight: SIZE_NUM_76
      })
    }
    .title(this.customNavDestinationTitle(), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_24VP),
        LengthMetrics.vp(PADDING_32VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_24VP),
        LengthMetrics.vp(PADDING_32VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}