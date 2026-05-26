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
import { SelectDialog } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@ComponentV2
export struct CustomSelectDialog {
  // Set the default selected radio button index.
  private radioIndex = 0;
  private dialogControllerList: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogControllerList = new CustomDialogController({
      builder: SelectDialog({
        title: $r('app.string.selection_dialog_label'),
        selectedIndex: this.radioIndex,
        confirm: {
          value: $r('app.string.cancel_label'),
          action: () => {
            hilog.info(0x00, 'CustomSelectDialog', 'The cancel button has been clicked currently.');
          }
        },
        radioContent: [
          {
            title: $r('app.string.option_text_one_label'),
            action: () => {
              this.radioIndex = 0;
            }
          },
          {
            title: $r('app.string.option_text_two_label'),
            action: () => {
              this.radioIndex = 1;
            }
          },
          {
            title: $r('app.string.option_text_three_label'),
            action: () => {
              this.radioIndex = 2;
            }
          }
        ]
      })
    });
  }

  build() {
    Row() {
      Text($r('app.string.selection_dialog_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .onClick(() => {
      if (this.dialogControllerList) {
        this.dialogControllerList.open();
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