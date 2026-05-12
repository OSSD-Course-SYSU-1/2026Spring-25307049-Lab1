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
import {
  CORNER_RADIUS_12,
  CORNER_RADIUS_16,
  CORNER_RADIUS_4,
  CORNER_RADIUS_8
} from '../../../../designtoken/CornerRadius'
import { PADDING_12VP, PADDING_28VP, PADDING_8VP } from '../../../../designtoken/Padding'
import { SIZE_NUM_10, SIZE_NUM_28, SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size'

@Builder
export function CustomToggle() {
  Column() {
    Row() {
      Text($r('app.string.customize_parameters_such_as_rounded_corners_and_colors_label'))
        .fontSize($r('sys.float.Subtitle_S'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_secondary'))
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_28VP,
      bottom: PADDING_8VP
    })

    Row() {
      Text($r('app.string.toggle_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor($r('sys.color.multi_color_02'))
        .switchStyle({
          pointRadius: CORNER_RADIUS_8,
          trackBorderRadius: CORNER_RADIUS_4,
          unselectedColor: Color.Grey
        })
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .justifyContent(FlexAlign.Center)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP
    })


    Row() {
      Text($r('app.string.customize_parameters_such_as_size_and_color_label'))
        .fontSize($r('sys.float.Subtitle_S'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_secondary'))
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_28VP,
      bottom: PADDING_8VP
    })

    Row() {
      Text($r('app.string.toggle_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: true })
        .width(SIZE_NUM_28)
        .height(SIZE_NUM_10)
        .selectedColor($r('app.color.multi_color_08'))
        .switchStyle({
          pointRadius: CORNER_RADIUS_8,
          trackBorderRadius: CORNER_RADIUS_12,
          pointColor: $r('sys.color.multi_color_08')
        })
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .justifyContent(FlexAlign.Center)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP
    })
  }
  .width(SIZE_PERCENT_100)
}