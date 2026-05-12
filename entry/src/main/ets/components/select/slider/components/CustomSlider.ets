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
import { SIZE_NUM_12, SIZE_NUM_14, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import {
  CORNER_RADIUS_16, CORNER_RADIUS_2, CORNER_RADIUS_4
} from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_6VP } from '../../../../designtoken/Padding';

@ComponentV2
export struct CustomSlider {
  private colorGradient: LinearGradient | undefined = undefined;

  aboutToAppear(): void {
    this.colorGradient = new LinearGradient([{ color: '#FFB76CFF', offset: 0 }, { color: '#FF1E53FF', offset: 1 }]);
  }

  build() {
    Column() {
      subTitleBuilder('Linear Gradient')

      Row() {
        Slider({
          value: INTEGER_50,
          min: INTEGER_0,
          max: INTEGER_100,
          style: SliderStyle.InSet
        })
          .selectedColor(Color.Transparent)
          .trackColor(this.colorGradient!!)
          .onChange((value: number) => {
            hilog.info(0x00, 'CustomSlider', `Current slider progress value: ${value}`);
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

      subTitleBuilder('Shape')

      Row() {
        Slider({
          value: INTEGER_50,
          min: INTEGER_0,
          max: INTEGER_100,
          step: INTEGER_10,
          style: SliderStyle.InSet
        })
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .trackColor($r('sys.color.comp_background_tertiary'))
          .trackBorderRadius(CORNER_RADIUS_4)
          .blockSize({
            width: PADDING_12VP,
            height: PADDING_12VP
          })
          .blockColor(Color.White)
          .showSteps(true)
          .blockStyle({
            type: SliderBlockType.SHAPE,
            shape: new Rect({ width: SIZE_NUM_12, height: SIZE_NUM_12 }).radius(CORNER_RADIUS_2)
          })
          .onChange((value: number) => {
            hilog.info(0x00, 'CustomSlider', `Current slider progress value: ${value}`);
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

      subTitleBuilder('Image')

      Row() {
        Slider({
          value: INTEGER_50,
          min: INTEGER_0,
          max: INTEGER_100,
          step: INTEGER_10,
          style: SliderStyle.InSet
        })
          .selectedColor($r('sys.color.ohos_id_color_emphasize'))
          .trackColor($r('sys.color.comp_background_tertiary'))
          .blockSize({ width: SIZE_NUM_14, height: SIZE_NUM_14 })
          .blockColor(Color.White)
          .showSteps(true)
          .blockStyle({
            type: SliderBlockType.IMAGE,
            image: $r('app.media.heart_fill')
          })
          .onChange((value: number) => {
            hilog.info(0x00, 'CustomSlider', `Current slider progress value: ${value}`);
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