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
import { DotRadio } from './components/DotRadio';
import { TickRadio } from './components/TickRadio';
import { LengthMetrics } from '@kit.ArkUI';
import { PADDING_16VP, PADDING_24VP } from '../../../designtoken/Padding';

@Builder
export function RadioExampleBuilder() {
  RadioExample()
}

@ComponentV2
export struct RadioExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      Column() {
        TickRadio()
        DotRadio()
      }
      .padding({
        left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
        right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
      })
    }
    .title($r('app.string.radio_label'), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}