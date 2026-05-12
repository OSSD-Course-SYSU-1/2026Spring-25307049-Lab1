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
import { INTEGER_0, INTEGER_10, INTEGER_100, INTEGER_50 } from '../../../../constants/CommonConstants';
import { SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_6VP } from '../../../../designtoken/Padding';

@ComponentV2
export struct CombinationTypeSlider {
  @Local tipsValue: number = 40;

  build() {
    Column() {
      subTitleBuilder($r('app.string.blue_hand_following_slider_label'))

      Row() {
        Slider({
          value: INTEGER_50,
          min: INTEGER_0,
          max: INTEGER_100,
          style: SliderStyle.InSet
        })
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange((value: number) => {
            hilog.info(0x00, 'CombinationTypeSlider', `Current slider progress value: ${value}`);
          })
      }
      .width(SIZE_PERCENT_100)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      // When the style of the slider is set to SliderStyle.InSet, the left and right spacing are 6vp respectively.
      .padding({
        left: PADDING_6VP,
        right: PADDING_6VP,
        top: PADDING_12VP,
        bottom: PADDING_12VP
      })

      subTitleBuilder($r('app.string.slider_with_bubble_label'))

      Row() {
        Slider({
          value: this.tipsValue,
          min: INTEGER_0,
          max: INTEGER_100,
          style: SliderStyle.InSet
        })
          .showTips(true, this.tipsValue.toFixed())
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange(value => {
            this.tipsValue = value;
          })
      }
      .width(SIZE_PERCENT_100)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      // When the style of the slider is set to SliderStyle.InSet, the left and right spacing are 6vp respectively.
      .padding({
        left: PADDING_6VP,
        right: PADDING_6VP,
        top: PADDING_12VP,
        bottom: PADDING_12VP
      })

      subTitleBuilder($r('app.string.intermittent_sliding_label'))

      Row() {
        Slider({
          value: INTEGER_50,
          min: INTEGER_0,
          max: INTEGER_100,
          step: INTEGER_10,
          style: SliderStyle.InSet
        })
          .showSteps(true)
          .trackColor($r('sys.color.comp_background_tertiary'))
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .onChange((value: number) => {
            hilog.info(0x00, 'CombinationTypeSlider', `Current slider progress value: ${value}`);
          })
      }
      .width(SIZE_PERCENT_100)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      // When the style of the slider is set to SliderStyle.InSet, the left and right spacing are 6vp respectively.
      .padding({
        left: PADDING_6VP,
        right: PADDING_6VP,
        top: PADDING_12VP,
        bottom: PADDING_12VP
      })
    }
    .width(SIZE_PERCENT_100)
  }
}