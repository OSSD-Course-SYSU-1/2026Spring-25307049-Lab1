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
import { BreakpointType } from '../../../model/BreakpointType';
import { CollapsedActionBar } from './components/CollapsedActionBar';
import { HorizontalActionBar } from './components/HorizontalActionBar';
import { VerticalActionBar } from './components/VerticalActionBar';
import { LengthMetrics } from '@kit.ArkUI';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { SIZE_NUM_48, SIZE_PERCENT_100 } from '../../../designtoken/Size';
import { PADDING_16VP, PADDING_24VP, PADDING_28VP, PADDING_36VP } from '../../../designtoken/Padding';

@Builder
export function ActionBarExampleBuilder() {
  ActionBarExample()
}

@ComponentV2
struct ActionBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      Column() {
        Row() {
          Text($r('app.string.horizontal_label'))
            .fontSize($r('sys.float.Subtitle_S'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_secondary'))
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .padding({ left: this.breakpointModel.getValue(PADDING_28VP, PADDING_28VP, PADDING_36VP) })

        CollapsedActionBar()
        HorizontalActionBar()

        Row() {
          Text($r('app.string.vertical_side_floating_action_bar_label'))
            .fontSize($r('sys.float.Subtitle_S'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_secondary'))
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .padding({ left: this.breakpointModel.getValue(PADDING_28VP, PADDING_28VP, PADDING_36VP) })

        VerticalActionBar()
      }
    }
    .title($r('app.string.action_bar_label'), {
      paddingStart: new BreakpointType(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)).getValue(this.breakpointModel.currentWidthBreakpoint),
      paddingEnd: new BreakpointType(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)).getValue(this.breakpointModel.currentWidthBreakpoint)
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}