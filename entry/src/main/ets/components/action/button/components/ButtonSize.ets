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
import { LengthMetrics } from '@kit.ArkUI'
import { subTitleBuilder } from '../../../../builder/CustomBuilder'
import { CORNER_RADIUS_20 } from '../../../../designtoken/CornerRadius'
import { PADDING_12VP, PADDING_16VP } from '../../../../designtoken/Padding'
import { SPACE_12, SPACE_16 } from '../../../../designtoken/Space'
import { CommonUtils } from '../../../../utils/CommonUtils'

@Builder
export function ButtonSize() {
  Column() {
    subTitleBuilder($r('app.string.button_size_label'))
    Column({ space: SPACE_16 }) {
      Flex({
        alignItems: ItemAlign.Center,
        justifyContent: FlexAlign.Start,
        space: { main: LengthMetrics.vp(SPACE_12) }
      }) {
        Button('Medium', { controlSize: ControlSize.NORMAL, buttonStyle: ButtonStyleMode.EMPHASIZED })
          .onClick(() => {
            CommonUtils.showToast($r('app.string.medium_sized_button_toast_label'));
          })
        Button('Small', { controlSize: ControlSize.SMALL, buttonStyle: ButtonStyleMode.EMPHASIZED })
          .onClick(() => {
            CommonUtils.showToast($r('app.string.small_sized_button_toast_label'));
          })
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