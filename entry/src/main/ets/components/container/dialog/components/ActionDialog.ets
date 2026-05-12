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
import { SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { SPACE_12 } from '../../../../designtoken/Space';

@ComponentV2
export struct ActionDialog {
  @Local isPressedActionDialog: boolean = false;
  private dialogControllerConfirm: CustomDialogController | undefined = undefined;

  @Builder
  buildContent(): void {
    Column() {
      Text($r('app.string.operation_confirmation_dialog_label'))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.JUSTIFY)
        .wordBreak(WordBreak.HYPHENATION)
    }
    .width(SIZE_PERCENT_100)
  }

  aboutToAppear(): void {
    this.dialogControllerConfirm = new CustomDialogController({
      builder: CustomContentDialog({
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              hilog.info(0x00, 'ActionDialog', 'The cancel button has been clicked currently.');
            }
          },
          {
            value: $r('app.string.delete_label'),
            role: ButtonRole.ERROR,
            action: () => {
              hilog.info(0x00, 'ActionDialog', 'The delete button has been clicked currently.');
            }
          }
        ]
      })
    });
  }

  build() {
    Column({ space: SPACE_12 }) {
      Row() {
        Text($r('app.string.operation_confirmation_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        Blank()

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .onClick(() => {
        if (this.dialogControllerConfirm) {
          this.dialogControllerConfirm.open();
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
