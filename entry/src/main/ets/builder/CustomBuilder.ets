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
import { LAYOUT_WEIGHT_1 } from '../constants/CommonConstants'
import { PADDING_12VP, PADDING_24VP, PADDING_28VP, PADDING_8VP } from '../designtoken/Padding'
import { SIZE_NUM_1, SIZE_NUM_20, SIZE_NUM_24, SIZE_NUM_56, SIZE_PERCENT_100 } from '../designtoken/Size'

@Builder
export function groupHeader(title: ResourceStr) {
  Row() {
    Text(title)
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
  .backgroundColor($r('app.color.default_background_color'))
}

@Builder
export function headlineBuilder(val: ResourceStr) {
  Row() {
    Text(val)
      .fontSize($r('sys.float.Subtitle_L'))
      .fontColor($r('sys.color.font_primary'))
      .lineHeight(SIZE_NUM_24)
      .fontWeight(FontWeight.Bold)
  }
  .width(SIZE_PERCENT_100)
  .padding({
    top: PADDING_24VP,
    bottom: PADDING_8VP
  })
}

@Builder
export function subTitleBuilder(val: ResourceStr, leftPadding: Length | undefined = PADDING_12VP) {
  Row() {
    Text(val)
      .fontSize($r('sys.float.Subtitle_S'))
      .fontColor($r('sys.color.font_secondary'))
      .lineHeight(SIZE_NUM_20)
      .fontWeight(FontWeight.Medium)
  }
  .width(SIZE_PERCENT_100)
  .padding({
    left: leftPadding,
    top: PADDING_28VP,
    bottom: PADDING_8VP
  })
}

@Builder
export function noMore() {
  Row() {
    Divider()
      .color($r('sys.color.comp_background_tertiary'))
      .height(SIZE_NUM_1)
      .layoutWeight(LAYOUT_WEIGHT_1)

    Text($r('app.string.no_more_label'))
      .fontColor($r('sys.color.font_secondary'))
      .fontSize($r('sys.float.Caption_M'))
      .margin($r('sys.float.padding_level6'))

    Divider()
      .color($r('sys.color.comp_background_tertiary'))
      .height(SIZE_NUM_1)
      .layoutWeight(LAYOUT_WEIGHT_1)
  }
  .alignItems(VerticalAlign.Center)
  .width(SIZE_PERCENT_100)
}