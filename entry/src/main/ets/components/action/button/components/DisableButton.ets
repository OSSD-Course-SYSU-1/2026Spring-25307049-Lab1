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
import { LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants'
import { CORNER_RADIUS_20 } from '../../../../designtoken/CornerRadius'
import { PADDING_12VP, PADDING_16VP } from '../../../../designtoken/Padding'
import { SIZE_NUM_40 } from '../../../../designtoken/Size'
import { SPACE_12, SPACE_16 } from '../../../../designtoken/Space'

@Builder
export function DisableButton() {
  Column() {
    subTitleBuilder($r('app.string.disabled_status_or_disable_label'))
    Column({ space: SPACE_16 }) {
      Row({ space: SPACE_12 }) {
        Button('Disable')
          .layoutWeight(LAYOUT_WEIGHT_1)
          .height(SIZE_NUM_40)
          .buttonStyle(ButtonStyleMode.EMPHASIZED)
          .stateEffect(false)
          .hoverEffect(HoverEffect.None)
          .enabled(false)
        Button('Disable')
          .layoutWeight(LAYOUT_WEIGHT_1)
          .height(SIZE_NUM_40)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .stateEffect(false)
          .hoverEffect(HoverEffect.None)
          .enabled(false)
      }

      Row({ space: SPACE_12 }) {
        Button('Disable')
          .layoutWeight(LAYOUT_WEIGHT_1)
          .height(SIZE_NUM_40)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .role(ButtonRole.ERROR)
          .stateEffect(false)
          .hoverEffect(HoverEffect.None)
          .enabled(false)
        Button('Disable')
          .layoutWeight(LAYOUT_WEIGHT_1)
          .height(SIZE_NUM_40)
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .stateEffect(false)
          .hoverEffect(HoverEffect.None)
          .enabled(false)
      }
    }
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius(CORNER_RADIUS_20)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_16VP,
      bottom: PADDING_16VP
    })
  }
}