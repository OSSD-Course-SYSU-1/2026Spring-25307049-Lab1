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
import { subTitleBuilder } from '../../../../builder/CustomBuilder';
import { BreakpointModel } from '../../../../model/BreakpointModel';
import { hilog } from '@kit.PerformanceAnalysisKit';
import {
  SIZE_NUM_1,
  SIZE_NUM_24,
  SIZE_NUM_40,
  SIZE_NUM_475,
  SIZE_NUM_56,
  SIZE_NUM_592,
  SIZE_NUM_65,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { PADDING_0VP, PADDING_12VP, PADDING_16VP, PADDING_5VP, PADDING_8VP } from '../../../../designtoken/Padding';
import {
  DURATION_100, DURATION_400, INTEGER_0, LAYOUT_WEIGHT_1
} from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16, CORNER_RADIUS_40 } from '../../../../designtoken/CornerRadius';

@ComponentV2
export struct MutiBindSheet {
  @Local isShowSheetBuilder: boolean = false;
  @Local isShowSheetOneModalBuilder: boolean = false;
  @Local isShowSheetTwoNonModalBuilder: boolean = false;
  @Local title: ResourceStr = $r('app.string.title_label');
  @Local flag: boolean = false;
  @Local translateX: number = 0;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @Builder
  SheetBuilder() {
    Stack() {
      Column() {
        Row() {
          Text(this.title)
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_S'))
            .fontWeight(FontWeight.Bold)
        }
        .height(SIZE_NUM_65)
        .width(SIZE_PERCENT_100)
        .padding({ top: PADDING_5VP })

        Flex({ direction: FlexDirection.Column }) {
          Column()
            .width(SIZE_PERCENT_100)
            .height('calc(100% - 142vp)')
            .backgroundColor($r('app.color.bindSheet_content_background_color'))

          Button($r('app.string.conversion_same_panel_label'))
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_40)
            .margin({ top: PADDING_16VP })
            .buttonStyle(ButtonStyleMode.NORMAL)
            .onClick(() => {
              setTimeout(() => {
                this.title = $r('app.string.subtitle_label');
              }, DURATION_100)
              this.getUIContext()?.animateTo({
                duration: DURATION_400,
                curve: Curve.EaseOut,
                playMode: PlayMode.Normal,
                onFinish: () => {
                  hilog.info(0x00, 'MutiBindSheet', 'play end');
                }
              }, () => {
                this.flag = !this.flag;
              });
            });
        }
        .height(SIZE_PERCENT_100)
      }
      .margin({
        left: PADDING_16VP,
        right: PADDING_16VP,
        bottom: this.breakpointModel.getValue(PADDING_16VP, PADDING_0VP, PADDING_0VP)
      })
      .translate({ x: this.flag ? -this.translateX : INTEGER_0 })

      SheetBuilder2({ title: this.title!!, flag: this.flag!! })
        .width(SIZE_PERCENT_100)
        .height(SIZE_PERCENT_100)
        .translate({ x: this.flag ? INTEGER_0 : this.translateX })
        .onAreaChange((_oldValue: Area, newValue: Area) => {
          this.translateX = newValue.width as number;
        });
    }
    .height(SIZE_PERCENT_100)
  }

  @Builder
  myBuilder() {
    Column() {
      Column()
        .width(SIZE_PERCENT_100)
        .height(SIZE_PERCENT_100)
        .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .margin({
      left: PADDING_16VP,
      right: PADDING_16VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }

  @Builder
  myMultipleBuilder() {
    Flex({ direction: FlexDirection.Column }) {
      Column()
        .width(SIZE_PERCENT_100)
        .height('calc(100% - 72vp)')
        .backgroundColor($r('app.color.bindSheet_content_background_color'))
      Button($r('app.string.multiple_panels_label'))
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_40)
        .margin({ top: PADDING_16VP })
        .buttonStyle(ButtonStyleMode.NORMAL)
        .onClick(() => {
          this.isShowSheetTwoNonModalBuilder = true;
        })
        .bindSheet(this.isShowSheetTwoNonModalBuilder!!, this.myBuilder(), {
          height: SIZE_NUM_592,
          showClose: true,
          title: { title: $r('app.string.sheet2_label') }
        })
    }
    .margin({
      left: PADDING_16VP,
      right: PADDING_16VP,
      bottom: this.breakpointModel.getValue(PADDING_16VP, PADDING_0VP, PADDING_0VP)
    })
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.panel_navigation_label'))
      Column() {
        Row() {
          Row() {
            Text($r('app.string.conversion_same_panel_label'))
              .fontSize($r('sys.float.Subtitle_M'))
              .fontWeight(FontWeight.Medium)
              .fontColor($r('sys.color.font_primary'))

            Blank()

            SymbolGlyph($r('sys.symbol.chevron_right'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_fourth')])
          }
          .width(SIZE_PERCENT_100)
          .height(SIZE_NUM_56)
          .borderRadius(CORNER_RADIUS_16)
          .padding({
            left: PADDING_12VP,
            right: PADDING_12VP
          })
          .onClick(() => {
            this.isShowSheetBuilder = !this.isShowSheetBuilder;
          })
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor($r('app.color.list_item_pressed_color'))
            }
          })
        }
        .bindSheet(this.isShowSheetBuilder!!, this.SheetBuilder(), {
          detents: [SheetSize.MEDIUM],
          showClose: true
        })

        Divider()
          .strokeWidth(SIZE_NUM_1)
          .color($r('sys.color.comp_background_tertiary'))
          .padding({
            left: PADDING_12VP,
            right: PADDING_12VP
          })
        Row() {
          Row() {
            Text($r('app.string.multiple_panels_label'))
              .fontSize($r('sys.float.Subtitle_M'))
              .fontWeight(FontWeight.Medium)
              .fontColor($r('sys.color.font_primary'))

            Blank()

            SymbolGlyph($r('sys.symbol.chevron_right'))
              .fontSize($r('sys.float.Title_M'))
              .fontColor([$r('sys.color.icon_fourth')])
          }
          .width(SIZE_PERCENT_100)
          .height(SIZE_NUM_56)
          .borderRadius(CORNER_RADIUS_16)
          .padding({
            left: PADDING_12VP,
            right: PADDING_12VP
          })
          .onClick(() => {
            this.isShowSheetOneModalBuilder = true;
          })
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor($r('app.color.list_item_pressed_color'))
            }
          })
        }
        .bindSheet(this.isShowSheetOneModalBuilder!!, this.myMultipleBuilder(), {
          height: SIZE_NUM_475,
          showClose: true,
          title: { title: $r('app.string.sheet1_label') }
        })
      }
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .width(SIZE_PERCENT_100)
    }
    .width(SIZE_PERCENT_100)
  }
}

// Jump to the second page on the same panel
@ComponentV2
struct SheetBuilder2 {
  @Param title: ResourceStr = '';
  @Param flag: boolean = false;
  @Event $title: (val: ResourceStr) => void = () => {
  };
  @Event $flag: (val: boolean) => void = () => {
  };

  build() {
    Column() {
      Row() {
        Column() {
          Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
            .height(SIZE_NUM_24)
            .width(SIZE_NUM_24)
            .fillColor($r('sys.color.font_primary'));
        }
        .borderRadius(CORNER_RADIUS_40)
        .width(SIZE_NUM_40)
        .height(SIZE_NUM_40)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .margin({ right: PADDING_8VP })
        .onClick(() => {
          setTimeout(() => {
            this.$title($r('app.string.title_label'));
          }, DURATION_100);
          this.getUIContext()?.animateTo({
            duration: DURATION_400,
            curve: Curve.EaseOut,
            playMode: PlayMode.Normal,
            onFinish: () => {
              hilog.info(0x00, 'SheetBuilder2', 'play end');
            }
          }, () => {
            this.$flag(!this.flag);
          });
        });

        Text(this.title)
          .fontSize($r('sys.float.Title_S'))
          .fontWeight(FontWeight.Bold)
      }
      .height(SIZE_NUM_65)
      .width(SIZE_PERCENT_100)
      .padding({
        left: PADDING_16VP,
        top: PADDING_5VP
      })

      Column() {
        Column()
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width(SIZE_PERCENT_100)
          .height(SIZE_PERCENT_100)
          .layoutWeight(LAYOUT_WEIGHT_1)
          .backgroundColor($r('app.color.bindSheet_content_background_color'))
      }
      .margin({
        left: PADDING_16VP,
        right: PADDING_16VP
      })
      .backgroundColor($r('sys.color.comp_background_list_card'))
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_PERCENT_100)
  }
}