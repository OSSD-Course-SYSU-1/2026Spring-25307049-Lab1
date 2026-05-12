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
import {
  FLOAT_0_POINT_5,
  INTEGER_1,
  INTEGER_2,
  INTEGER_5,
  LAYOUT_WEIGHT_1
} from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16, CORNER_RADIUS_4 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_8VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_28, SIZE_NUM_40, SIZE_NUM_77, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { SPACE_8 } from '../../../../designtoken/Space';
import { BreakpointModel } from '../../../../model/BreakpointModel';

@ComponentV2
export struct NonInteractiveRating {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      subTitleBuilder($r('app.string.non_interactive_rating_bar_label'))

      Row() {
        Rating({ rating: INTEGER_1, indicator: true })
          .stars(INTEGER_5)
          .stepSize(FLOAT_0_POINT_5)
          .width(SIZE_NUM_28 * 5)
          .height(SIZE_NUM_28)
      }
      .width(SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding(PADDING_12VP)

      subTitleBuilder($r('app.string.common_scenarios_for_non_interactive_rating_bar_label'))

      Row({ space: SPACE_8 }) {
        Image($r('app.media.avatar1'))
          .width(SIZE_NUM_40)
          .height(SIZE_NUM_40)

        Column() {
          Row() {
            Text('Jia')
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .fontWeight(FontWeight.Bold)

            Text('First')
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
          .width(SIZE_PERCENT_100)
          .justifyContent(FlexAlign.SpaceBetween)

          Row({ space: SPACE_8 }) {
            Text('Jia')
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Caption_M'))
              .fontWeight(FontWeight.Regular)

            Rating({ rating: INTEGER_2, indicator: true })
              .stars(INTEGER_5)
              .stepSize(FLOAT_0_POINT_5)

            Text('2017/12/08')
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Caption_M'))
              .fontWeight(FontWeight.Regular)

            Blank()
          }
          .width(SIZE_PERCENT_100)
          .margin({ bottom: PADDING_12VP })

          Row() {
            Text($r('app.string.comment_section_content_info_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.JUSTIFY)  // Enables justification
              .wordBreak(WordBreak.HYPHENATION)
          }
          .width(SIZE_PERCENT_100)
          .margin({ bottom: PADDING_8VP })

          Row({ space: this.breakpointModel.getValue(PADDING_8VP, PADDING_12VP, PADDING_12VP) }) {
            Image($r('app.media.img_1'))
              .width(SIZE_NUM_77)
              .height(SIZE_NUM_77)
              .borderRadius(CORNER_RADIUS_4)
              .clip(true)

            Image($r('app.media.img_2'))
              .width(SIZE_NUM_77)
              .height(SIZE_NUM_77)
              .borderRadius(CORNER_RADIUS_4)
              .clip(true)

            Image($r('app.media.img_3'))
              .width(SIZE_NUM_77)
              .height(SIZE_NUM_77)
              .borderRadius(CORNER_RADIUS_4)
              .clip(true)
          }
          .width(SIZE_PERCENT_100)
          .justifyContent(FlexAlign.Start)
        }
        .layoutWeight(LAYOUT_WEIGHT_1)
      }
      .width(SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Top)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding(PADDING_12VP)
    }
    .width(SIZE_PERCENT_100)
  }
}