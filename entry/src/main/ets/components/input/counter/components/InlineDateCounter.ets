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
import { CounterComponent, CounterType, DateData } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import { COUNTER_DATA_DAY, COUNTER_DATA_MONTH, COUNTER_DATA_YEAR } from '../../../../constants/CommonConstants';

@Builder
export function InlineDateCounter() {
  Column() {
    subTitleBuilder($r('app.string.inline_date_counter_label'))

    Row() {
      CounterComponent({
        options: {
          type: CounterType.INLINE_DATE,
          dateOptions: {
            year: COUNTER_DATA_YEAR,
            month: COUNTER_DATA_MONTH,
            day: COUNTER_DATA_DAY,
            onDateChange: (date: DateData) => {
              hilog.info(0x00, 'InlineDateCounter', 'onDateChange Date: ' + JSON.stringify(date));
            }
          }
        }
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