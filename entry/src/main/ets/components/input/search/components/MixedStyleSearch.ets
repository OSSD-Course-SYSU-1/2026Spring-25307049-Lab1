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
import { SIZE_NUM_24, SIZE_NUM_40, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { SPACE_8 } from '../../../../designtoken/Space';
import { LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';

@Builder
export function MixedStyleSearch() {
  Column() {
    subTitleBuilder($r('app.string.search_box_and_icon_label'))

    Row({ space: SPACE_8 }) {
      Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_40)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .textFont({
          size: $r('sys.float.Body_L'),
          weight: FontWeight.Regular
        })
        .onSubmit((value: string) => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword length: ${value.length}`);
        })
        .onChange(() => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword is changed.`);
        })
        .layoutWeight(LAYOUT_WEIGHT_1)

      Stack() {
        Circle()
          .width(SIZE_NUM_40)
          .height(SIZE_NUM_40)
          .fill($r('sys.color.comp_background_tertiary'))

        Image($r('sys.media.ohos_ic_public_scan'))
          .width(SIZE_NUM_24)
          .height(SIZE_NUM_24)
      }
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)

    subTitleBuilder($r('app.string.icon_and_search_box_label'))

    Row({ space: SPACE_8 }) {
      Stack() {
        Circle()
          .width(SIZE_NUM_40)
          .height(SIZE_NUM_40)
          .fill($r('sys.color.comp_background_tertiary'))

        SymbolGlyph($r('sys.symbol.chevron_left'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_primary')])
      }

      Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_40)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .textFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .onSubmit((value: string) => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword length: ${value.length}`);
        })
        .onChange(() => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword is changed.`);
        })
        .layoutWeight(LAYOUT_WEIGHT_1)
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)

    subTitleBuilder($r('app.string.icon_and_search_box_and_icon_label'))

    Row({ space: SPACE_8 }) {
      Stack() {
        Circle()
          .width(SIZE_NUM_40)
          .height(SIZE_NUM_40)
          .fill($r('sys.color.comp_background_tertiary'))

        SymbolGlyph($r('sys.symbol.chevron_left'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_primary')])
      }

      Search({ value: '', placeholder: $r('app.string.search_placeholder_label') })
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_40)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .placeholderColor($r('sys.color.font_secondary'))
        .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .textFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
        .onSubmit((value: string) => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword length: ${value.length}`);
        })
        .onChange(() => {
          hilog.info(0x00, 'MixedStyleSearch', `The search keyword is changed.`);
        })
        .layoutWeight(LAYOUT_WEIGHT_1)

      Stack() {
        Circle()
          .width(SIZE_NUM_40)
          .height(SIZE_NUM_40)
          .fill($r('sys.color.comp_background_tertiary'))

        Image($r('sys.media.ohos_ic_public_scan'))
          .width(SIZE_NUM_24)
          .height(SIZE_NUM_24)
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