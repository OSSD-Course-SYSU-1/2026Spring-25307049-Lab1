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
import { LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import {
  SIZE_NUM_16,
  SIZE_NUM_24,
  SIZE_NUM_40,
  SIZE_NUM_48,
  SIZE_NUM_56,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { SPACE_8 } from '../../../../designtoken/Space';

@ComponentV2
export struct InputDialog {
  @Local textValue1: string = '';
  @Local textValue2: string = '';
  private dialogController: CustomDialogController | undefined = undefined;

  aboutToAppear(): void {
    this.dialogController = new CustomDialogController({
      builder: CustomContentDialog({
        primaryTitle: $r('app.string.input_dialog_label'),
        contentBuilder: () => {
          this.buildContent();
        },
      }),
    });
  }

  @Builder
  buildContent(): void {
    Column({ space: SPACE_8 }) {
      TextInput({ placeholder: 'Title', text: this.textValue1!! })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .showUnderline(true)
        .underlineColor({
          normal: $r('sys.color.comp_divider'),
          typing: $r('app.color.text_box_typing_color')
        })

      TextInput({ placeholder: 'Hint', text: this.textValue2!! })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .showUnderline(true)
        .underlineColor({
          normal: $r('sys.color.comp_divider'),
          typing: $r('app.color.text_box_typing_color')
        })

      Row() {
        Button($r('app.string.cancel_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.dialogController) {
              this.dialogController.close();
            }
          })

        Divider()
          .vertical(true)
          .width(SIZE_NUM_16)
          .height(SIZE_NUM_24)
          .color($r('sys.color.comp_divider'))

        Button($r('app.string.confirm_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(LAYOUT_WEIGHT_1)
          .enabled(this.textValue2.trim() === '' ? false : true)
          .onClick(() => {
            if (this.dialogController) {
              this.dialogController.close();
            }
          })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_40)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Row() {
      Text($r('app.string.input_dialog_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .onClick(() => {
      this.dialogController?.open();
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