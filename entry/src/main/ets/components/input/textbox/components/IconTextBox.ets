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
import { TEXT_MAX_LENGTH_10, TEXT_MAX_LINES_1 } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_32VP } from '../../../../designtoken/Padding';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@Builder
export function IconTextBox() {
  Column() {
    subTitleBuilder($r('app.string.icon_text_box_label'))

    Row() {
      Stack({ alignContent: Alignment.Start }) {
        TextInput({ placeholder: $r('app.string.textinput_placeholder_label_1') })
          .width(SIZE_PERCENT_100)
          .showUnderline(true)
          .underlineColor({
            normal: $r('sys.color.comp_divider'),
            typing: $r('app.color.text_box_typing_color'),
            error: $r('sys.color.warning'),
            disable: Color.Gray
          })
          .maxLines(TEXT_MAX_LINES_1)
          .maxLength(TEXT_MAX_LENGTH_10)
          .padding({ left: PADDING_32VP })

        SymbolGlyph($r('sys.symbol.person'))
          .fontColor([$r('sys.color.icon_secondary')])
          .fontSize($r('sys.float.Title_M'))
      }
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
    .margin({ bottom: PADDING_12VP })
  }
  .width(SIZE_PERCENT_100)
}