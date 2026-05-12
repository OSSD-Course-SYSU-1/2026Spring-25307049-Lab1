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
import { groupHeader } from '../../../builder/CustomBuilder';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { DropdownMenu } from './components/DropdownMenu';
import { IconStyledMenu } from './components/IconStyledMenu';
import { LongPressFloatingMenu } from './components/LongPressFloatingMenu';
import { TitleStyledMenu } from './components/TitleStyledMenu';
import { LengthMetrics } from '@kit.ArkUI';
import { SIZE_NUM_12, SIZE_PERCENT_100 } from '../../../designtoken/Size';
import { PADDING_16VP, PADDING_24VP } from '../../../designtoken/Padding';

@Builder
export function MenuExampleBuilder() {
  MenuExample()
}

@ComponentV2
struct MenuExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      List() {
        ListItemGroup({ header: groupHeader($r('app.string.basic_style_label')) }) {
          DropdownMenu()
          IconStyledMenu()
          TitleStyledMenu()
        }
        .divider({
          strokeWidth: SIZE_NUM_12,
          color: $r('sys.color.background_secondary'),
        })

        ListItemGroup({ header: groupHeader($r('app.string.floating_menu_label')) }) {
          LongPressFloatingMenu()
        }
        .divider({
          strokeWidth: SIZE_NUM_12,
          color: $r('sys.color.background_secondary'),
        })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .padding({
        left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
        right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
      })
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.Header)
      .edgeEffect(EdgeEffect.Spring)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .title($r('app.string.menu_label'), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}