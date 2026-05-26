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
import { COUNTER_INITIAL_VALUE, COUNTER_MAX_VALUE, COUNTER_MIN_VALUE } from '../../../../constants/CommonConstants';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';

@Builder
export function ListCounter() {
  Column() {
    subTitleBuilder($r('app.string.list_counter_label'))

    Row() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Divider()
          .width('calc(100% - 130vp)')
          .color($r('sys.color.comp_divider'))

        CounterComponent({
          options: {
            type: CounterType.LIST,
            numberOptions: {
              label: $r('app.string.quantity_label'),
              min: COUNTER_MIN_VALUE,
              value: COUNTER_INITIAL_VALUE,
              max: COUNTER_MAX_VALUE
            }
          }
        })
      }
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