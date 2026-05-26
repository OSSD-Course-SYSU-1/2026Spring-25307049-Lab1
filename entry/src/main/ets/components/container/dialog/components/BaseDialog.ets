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
import { CustomContentDialog } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56, SIZE_NUM_80, SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@ComponentV2
export struct BaseDialog {
  // Dialog controller
  private basicDialogController: CustomDialogController | undefined = undefined;
  private doubleTitleDialogController: CustomDialogController | undefined = undefined;
  private threeButtonDialogController: CustomDialogController | undefined = undefined;

  @Builder
  buildContent(): void {
    Column() {
      Text($r('app.string.content_label'))
        .fontColor($r('sys.color.font_emphasize'))
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.dialog_content_background_color'))
  }

  aboutToAppear(): void {
    this.basicDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              hilog.info(0x00, 'BaseDialog', 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL
          }
        ]
      })
    });
    this.doubleTitleDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        secondaryTitle: 'Auxiliary Text',
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              hilog.info(0x00, 'BaseDialog', 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL
          }
        ]
      })
    });
    this.threeButtonDialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.title_area_label'),
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.EMPHASIZED,
            action: () => {
              hilog.info(0x00, 'BaseDialog', 'Callback when the button is clicked')
            }
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
          },
          {
            value: $r('app.string.button_text_in_all_caps_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
          }
        ]
      })
    });
  }

  build() {
    Column({ space: PADDING_12VP }) {
      Row() {
        Text($r('app.string.basic_components_of_dialog_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        Blank()

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .onClick(() => {
        if (this.basicDialogController) {
          this.basicDialogController.open();
        }
      })
      .borderRadius(CORNER_RADIUS_16)
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .padding({
        left: PADDING_12VP,
        right: PADDING_12VP
      })
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })

      Row() {
        Text($r('app.string.double_line_title_dialog_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        Blank()

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .onClick(() => {
        if (this.doubleTitleDialogController) {
          this.doubleTitleDialogController.open();
        }
      })
      .borderRadius(CORNER_RADIUS_16)
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .padding({
        left: PADDING_12VP,
        right: PADDING_12VP
      })
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })

      Row() {
        Text($r('app.string.three_line_button_dialog_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        Blank()

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .onClick(() => {
        if (this.threeButtonDialogController) {
          this.threeButtonDialogController.open();
        }
      })
      .borderRadius(CORNER_RADIUS_16)
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .padding({
        left: PADDING_12VP,
        right: PADDING_12VP
      })
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })
    }
  }
}