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
import { BreakpointModel } from '../../../model/BreakpointModel';
import { ActionList } from './components/ActionList';
import { ContentList } from './components/ContentList';
import { EfficientList } from './components/EfficientList';
import { LengthMetrics } from '@kit.ArkUI';
import { PADDING_16VP, PADDING_24VP } from '../../../designtoken/Padding';
import { SIZE_PERCENT_100 } from '../../../designtoken/Size';

@Builder
export function ListExampleBuilder() {
  ListExample()
}

@ComponentV2
struct ListExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          EfficientList()
          ActionList()
          ContentList()
        }
        .width(SIZE_PERCENT_100)
        .padding({
          left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
          right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
          bottom: PADDING_16VP
        })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .title($r('app.string.list_label'), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}