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
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_24, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { CommonUtils } from '../../../../utils/CommonUtils';
import { CryptoUtil } from '../../../../utils/CryptoUtil';

@ComponentV2
export struct LinearProgress {
  // Current progress value
  @Local currentProgress: number = 0;
  // Total progress bar value
  private total: number = 100;
  // Timer ID, used for clearing the
  private intervalId: number = -1;

  aboutToAppear() {
    this.startDownloadSimulation();
  }

  aboutToDisappear() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.linear_progress_bar_label'))

      Column() {
        Row() {
          Text(this.currentProgress < this.total ? $r('app.string.saving_label') :
            $r('app.string.download_complete_notification_label'))
            .fontSize($r('sys.float.Subtitle_S'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Medium)
          Text(`${this.currentProgress}%`)
            .fontSize($r('sys.float.Subtitle_S'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Medium)
        }
        .width(SIZE_PERCENT_100)
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Progress({ value: this.currentProgress, total: this.total, type: ProgressType.Linear })
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_24)
      }
      .width(SIZE_PERCENT_100)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding({
        left: PADDING_16VP,
        right: PADDING_16VP,
        top: PADDING_12VP,
        bottom: PADDING_12VP
      })
    }
    .width(SIZE_PERCENT_100)
  }

  // Simulate download process
  private startDownloadSimulation() {
    let increment: number = 0;
    // Update progress every 100ms
    this.intervalId = setInterval(() => {
      if (this.currentProgress >= this.total) {
        // Download complete
        clearInterval(this.intervalId);
        CommonUtils.showToast($r('app.string.download_complete_notification_label'));
      } else {
        // Increase progress by 2% - 5% randomly to simulate real-world fluctuations
        increment = CryptoUtil.generateRangeRandomSync(0, 3) + 2;
        this.currentProgress = Math.min(this.currentProgress + increment, this.total);
      }
    }, 100); // Update every 100ms
  }
}