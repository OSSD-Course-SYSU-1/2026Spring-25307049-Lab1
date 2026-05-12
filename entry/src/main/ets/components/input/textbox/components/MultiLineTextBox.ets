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
import { hilog } from '@kit.PerformanceAnalysisKit';
import { TEXT_MAX_LENGTH_100, TEXT_THRESHOLD_PERCENTAGE } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { PADDING_12VP } from '../../../../designtoken/Padding';

@Builder
export function MultiLineTextBox() {
  Column() {
    subTitleBuilder($r('app.string.multi_line_text_box_label'))

    Row() {
      TextArea({
        text: 'A'.repeat(98),
        placeholder: $r('app.string.textarea_placeholder_label_2')
      })
        .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .width(SIZE_PERCENT_100)
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .backgroundColor($r('sys.color.background_secondary'))
        .maxLength(TEXT_MAX_LENGTH_100)
        .borderRadius(CORNER_RADIUS_16)
        .showCounter(true, { thresholdPercentage: TEXT_THRESHOLD_PERCENTAGE, highlightBorder: true })
        .onChange((value: string) => {
          hilog.info(0x00, 'MultiLineTextBox', `The content of the input field is: ${value}`);
        })
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
  }
  .width(SIZE_PERCENT_100)
}