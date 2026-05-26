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
import { FLOAT_0_POINT_5, INTEGER_1, INTEGER_5 } from '../../../../constants/CommonConstants';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';

@Builder
export function InteractiveRating() {
  Column() {
    subTitleBuilder($r('app.string.interactive_rating_bar_label'))

    Row() {
      Rating({ rating: INTEGER_1, indicator: false })
        .stars(INTEGER_5)
        .stepSize(FLOAT_0_POINT_5)
        .onChange((value: number) => {
          hilog.info(0x00, 'InteractiveRating', `The present score stands at ${value}.`);
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