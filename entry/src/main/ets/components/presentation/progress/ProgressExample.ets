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
import { CapsuleProgress } from './components/CapsuleProgress';
import { CircleProgress } from './components/CircleProgress';
import { LinearProgress } from './components/LinearProgress';
import { LoadingStyleProgress } from './components/LoadingStyleProgress';
import { LengthMetrics } from '@kit.ArkUI';
import { PADDING_16VP, PADDING_24VP } from '../../../designtoken/Padding';

@Builder
export function ProgressExampleBuilder() {
  ProgressExample()
}

@ComponentV2
struct ProgressExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          LinearProgress()
          CapsuleProgress()
          CircleProgress()
          LoadingStyleProgress()
        }
        .padding({
          left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
          right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
        })
      }
      .scrollBar(BarState.Off)
    }
    .title($r('app.string.progress_label'), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
  }
}