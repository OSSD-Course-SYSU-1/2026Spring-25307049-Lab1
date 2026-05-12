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
import { SIZE_NUM_40, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';

@Builder
export function StandardSearch() {
  Column() {
    subTitleBuilder($r('app.string.standard_search_box_label'))

    Row() {
      Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_40)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .textFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .onSubmit((value: string) => {
          hilog.info(0x00, 'StandardSearch', `The search keyword currently submitted in the search box is: ${value}`);
        })
        .onChange((value: string) => {
          hilog.info(0x00, 'StandardSearch', `The text content officially displayed in the search box is: ${value}`);
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