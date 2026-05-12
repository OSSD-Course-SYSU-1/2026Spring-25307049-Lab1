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
import { SIZE_NUM_48, SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@ComponentV2
export struct MessageDialog {
  @Local isRadioChecked: boolean = false;
  private dialogControllerCheckBox: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogControllerCheckBox = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.information_dialog_label'),
        contentBuilder: () => {
          this.buildContent();
        },
        buttons: [
          {
            value: $r('app.string.cancel_label'),
            buttonStyle: ButtonStyleMode.TEXTUAL,
            action: () => {
              hilog.info(0x00, 'MessageDialog', 'Callback when the button is clicked');
            }
          }
        ]
      })
    });
  }

  @Builder
  buildContent(): void {
    Column() {
      Text($r('app.string.message_content_label'))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.JUSTIFY)
        .wordBreak(WordBreak.HYPHENATION)

      Row() {
        Radio({ value: 'Radio', group: 'radioGroup' })
          .checked(this.isRadioChecked)

        Text($r('app.string.selected_content_text_label'))
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_48)
      .justifyContent(FlexAlign.Start)
      .onClick(() => {
        this.isRadioChecked = !this.isRadioChecked;
      })
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Row() {
      Text($r('app.string.information_dialog_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .onClick(() => {
      if (this.dialogControllerCheckBox) {
        this.dialogControllerCheckBox.open();
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