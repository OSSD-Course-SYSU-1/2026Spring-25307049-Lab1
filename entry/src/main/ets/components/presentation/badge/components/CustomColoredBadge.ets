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
import { INTEGER_1000, INTEGER_3, INTEGER_36, INTEGER_99 } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16, CORNER_RADIUS_8 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_40, SIZE_NUM_6, SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@Builder
export function CustomColoredBadge() {
  Column() {
    subTitleBuilder($r('app.string.custom_color_label'))

    Row() {
      Badge({
        count: INTEGER_3,
        position: BadgePosition.RightTop,
        style: {
          badgeColor: $r('sys.color.brand'),
          borderColor: $r('sys.color.brand')
        }
      }) {
        Rect({ width: SIZE_NUM_40, height: SIZE_NUM_40 })
          .radiusWidth(CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        value: INTEGER_36.toString(),
        position: BadgePosition.RightTop,
        style: {
          badgeColor: $r('sys.color.multi_color_04'),
          borderColor: $r('sys.color.multi_color_04')
        }
      }) {
        Rect({ width: SIZE_NUM_40, height: SIZE_NUM_40 })
          .radiusWidth(CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        count: INTEGER_1000,
        maxCount: INTEGER_99,
        position: BadgePosition.RightTop,
        style: {
          badgeColor: $r('sys.color.multi_color_10'),
          borderColor: $r('sys.color.multi_color_10')
        }
      }) {
        Rect({ width: SIZE_NUM_40, height: SIZE_NUM_40 })
          .radiusWidth(CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }

      Badge({
        value: '',
        position: BadgePosition.RightTop,
        style: {
          badgeSize: SIZE_NUM_6,
          badgeColor: $r('sys.color.multi_color_09'),
          borderColor: $r('sys.color.multi_color_09')
        }
      }) {
        Rect({ width: SIZE_NUM_40, height: SIZE_NUM_40 })
          .radiusWidth(CORNER_RADIUS_8)
          .fill($r('sys.color.background_secondary'))
      }
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
  }
  .width(SIZE_PERCENT_100)
}