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
import { LANDSCAPE_BIND_SHEET_NAME } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP, PADDING_28VP } from '../../../../designtoken/Padding';
import {
  SIZE_NUM_1,
  SIZE_NUM_200,
  SIZE_NUM_56,
  SIZE_NUM_600,
  SIZE_PERCENT_100,
  SIZE_PERCENT_700
} from '../../../../designtoken/Size';
import { BreakpointModel } from '../../../../model/BreakpointModel';

@ComponentV2
export struct BindSheetConfig {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  // Whether the modal page is displayed
  @Local isShowModalBuilder: boolean = false;
  @Local isShowNonModalBuilder: boolean = false;
  @Local isShowLargeModalBuilder: boolean = false;
  @Local isShowMediumModalBuilder: boolean = false;
  @Local isShowFreeModalBuilder: boolean = false;
  @Local isShowPortraitModalBuilder: boolean = false;
  @Local isShowScrollModalBuilder: boolean = false;

  @Builder
  myBuilder() {
    Column() {
      Column() {
      }
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
  myScrollBuilder() {
    List() {
      ListItem() {
        Text($r('app.string.empty_string_label'))
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_700)
      .margin({ bottom: PADDING_28VP })
      .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .alignListItem(ListItemAlign.Center)
    .width(SIZE_PERCENT_100)
    .height(SIZE_PERCENT_100)
    .padding({
      left: PADDING_16VP,
      right: PADDING_16VP
    })
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.overlay_label'))
      Column() {
        Row() {
          Row() {
            Text($r('app.string.modal_label'))
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
            this.isShowModalBuilder = true;
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
        .bindSheet(this.isShowModalBuilder!!, this.myBuilder(), {
          detents: [SheetSize.MEDIUM],
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: false
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
            Text($r('app.string.non_modal_label'))
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
            this.isShowNonModalBuilder = true;
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
        .bindSheet(this.isShowNonModalBuilder!!, this.myBuilder(), {
          detents: [SheetSize.MEDIUM],
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: true
        })
      }
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .width(SIZE_PERCENT_100)

      subTitleBuilder($r('app.string.modal_height_label'))
      Column() {
        Row() {
          Row() {
            Text($r('app.string.large_label'))
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
            this.isShowLargeModalBuilder = true;
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
        .bindSheet(this.isShowLargeModalBuilder!!, this.myBuilder(), {
          height: this.breakpointModel.getValue(SheetSize.LARGE, this.breakpointModel.windowHeight * 0.3,
            this.breakpointModel.windowHeight * 0.3),
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: false
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
            Text($r('app.string.medium_label'))
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
            this.isShowMediumModalBuilder = true;
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
        .bindSheet(this.isShowMediumModalBuilder!!, this.myBuilder(), {
          height: this.breakpointModel.getValue(SheetSize.MEDIUM, this.breakpointModel.windowHeight * 0.2,
            this.breakpointModel.windowHeight * 0.2),
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: false
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
            Text($r('app.string.free_label'))
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
            this.isShowFreeModalBuilder = true;
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
        .bindSheet(this.isShowFreeModalBuilder!!, this.myBuilder(), {
          height: SIZE_NUM_600,
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: false
        })
      }
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .width(SIZE_PERCENT_100)

      if (['xs', 'sm'].includes(this.breakpointModel.currentWidthBreakpoint)) {
        subTitleBuilder($r('app.string.bottom_panel_label'))
        Column() {
          Row() {
            Row() {
              Text($r('app.string.portrait_display_label'))
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
              this.isShowPortraitModalBuilder = true;
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
          .bindSheet(this.isShowPortraitModalBuilder!!, this.myBuilder(), {
            detents: [SheetSize.MEDIUM],
            blurStyle: BlurStyle.Thick,
            showClose: true,
            title: { title: $r('app.string.title_label') },
            enableOutsideInteractive: false
          })

          Divider()
            .strokeWidth(SIZE_NUM_1)
            .color($r('sys.color.comp_background_tertiary'))
            .padding({
              left: PADDING_12VP,
              right: PADDING_12VP
            })

          Row() {
            Text($r('app.string.landscape_display_label'))
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
            this.navPathStack.pushPath({ name: LANDSCAPE_BIND_SHEET_NAME });
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
        .borderRadius(CORNER_RADIUS_16)
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .width(SIZE_PERCENT_100)
      }

      subTitleBuilder($r('app.string.bottom_panel_scroll_response_priority_label'))
      Column() {
        Row() {
          Row() {
            Text($r('app.string.slide_content_and_title_label'))
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
            this.isShowScrollModalBuilder = true;
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
        .bindSheet(this.isShowScrollModalBuilder!!, this.myScrollBuilder(), {
          detents: [SheetSize.LARGE, SIZE_NUM_200],
          blurStyle: BlurStyle.Thick,
          showClose: true,
          title: { title: $r('app.string.title_label') },
          enableOutsideInteractive: false
        })
      }
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .width(SIZE_PERCENT_100)
    }
    .width(SIZE_PERCENT_100)
  }
}