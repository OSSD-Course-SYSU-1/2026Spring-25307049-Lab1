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
import { subTitleBuilder } from '../../../../builder/CustomBuilder'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size'
import { INTEGER_0, INTEGER_100, INTEGER_50, LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants'
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius'
import { PADDING_12VP, PADDING_3VP } from '../../../../designtoken/Padding'
import { SPACE_8 } from '../../../../designtoken/Space'

@Builder
export function BaseSlider() {
  Column() {
    subTitleBuilder($r('app.string.common_slider_label'))

    Row() {
      Slider({
        value: INTEGER_50,
        min: INTEGER_0,
        max: INTEGER_100,
        style: SliderStyle.NONE
      })
        .trackColor($r('sys.color.comp_background_tertiary'))
        .selectedColor($r('sys.color.comp_background_secondary'))
        .onChange((value: number) => {
          hilog.info(0x00, 'BaseSlider', `Current slider progress value: ${value}`);
        })
    }
    .width(SIZE_PERCENT_100)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)

    subTitleBuilder($r('app.string.outset_slider_label'))

    Row() {
      Slider({
        value: INTEGER_50,
        min: INTEGER_0,
        max: INTEGER_100,
        style: SliderStyle.OutSet
      })
        .trackColor($r('sys.color.comp_background_tertiary'))
        .onChange((value: number) => {
          hilog.info(0x00, 'BaseSlider', `Current slider progress value: ${value}`);
        })
    }
    .width(SIZE_PERCENT_100)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PADDING_3VP,
      right: PADDING_3VP,
      top: PADDING_12VP,
      bottom: PADDING_12VP
    })

    subTitleBuilder($r('app.string.inset_slider_label'))

    Row({ space: SPACE_8 }) {
      SymbolGlyph($r('sys.symbol.sun_max'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_secondary')])

      Slider({
        value: INTEGER_50,
        min: INTEGER_0,
        max: INTEGER_100,
        style: SliderStyle.InSet
      })
        .blockColor($r('sys.color.ohos_id_color_foreground_contrary'))
        .trackColor($r('sys.color.comp_background_tertiary'))
        .selectedColor($r('sys.color.ohos_id_color_emphasize'))
        .layoutWeight(LAYOUT_WEIGHT_1)
        .onChange((value: number) => {
          hilog.info(0x00, 'BaseSlider', `Current slider progress value: ${value}`);
        })

      SymbolGlyph($r('sys.symbol.sun_max_fill'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_secondary')])
    }
    .width(SIZE_PERCENT_100)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
  }
  .width(SIZE_PERCENT_100)
}