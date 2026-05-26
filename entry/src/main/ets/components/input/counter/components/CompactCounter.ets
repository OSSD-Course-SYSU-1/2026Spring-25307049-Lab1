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
import { CounterComponent, CounterType } from '@kit.ArkUI';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_16VP } from '../../../../designtoken/Padding';
import {
  COUNTER_INITIAL_VALUE,
  COUNTER_MAX_VALUE,
  COUNTER_MIN_VALUE,
  COUNTER_STEP_VALUE_1
} from '../../../../constants/CommonConstants';

@Builder
export function CompactCounter() {
  Column() {
    subTitleBuilder($r('app.string.compact_counter_label'))

    Row() {
      CounterComponent({
        options: {
          type: CounterType.COMPACT,
          numberOptions: {
            label: $r('app.string.quantity_label'),
            value: COUNTER_INITIAL_VALUE,
            min: COUNTER_MIN_VALUE,
            max: COUNTER_MAX_VALUE,
            step: COUNTER_STEP_VALUE_1
          }
        }
      })
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_16VP)
  }
  .width(SIZE_PERCENT_100)
}