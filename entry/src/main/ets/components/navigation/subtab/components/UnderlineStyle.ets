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
import { BreakpointModel } from '../../../../model/BreakpointModel';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PADDING_16VP, PADDING_28VP, PADDING_36VP, PADDING_8VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_280, SIZE_NUM_56, SIZE_NUM_96 } from '../../../../designtoken/Size';
import { DURATION_400 } from '../../../../constants/CommonConstants';

@ComponentV2
export struct UnderlineStyle {
  // selectedIndex controls the text color switching inside the custom TabBar
  @Local selectedIndex: number = 0;
  // currentIndex controls which tab page is displayed in the TabContent
  @Local currentIndex: number = 0;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private controller1: TabsController | undefined = undefined;
  private controller2: TabsController | undefined = undefined;

  @Builder
  UnderlineStyleTabBuilder(index: number, val: ResourceStr) {
    Column() {
      Text(val)
        .fontColor(this.selectedIndex === index ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Regular)
      Divider()
        .strokeWidth(this.selectedIndex === index ? 2 : 0)
        .color(this.selectedIndex === index ? $r('sys.color.font_emphasize') :
          $r('sys.color.ohos_id_color_background_transparent'))
        .margin({
          top: PADDING_8VP,
          left: PADDING_16VP,
          right: PADDING_16VP
        })
    }
    .width(SIZE_NUM_96)
    .height(SIZE_NUM_56)
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    this.controller1 = new TabsController();
    this.controller2 = new TabsController();
  }

  aboutToDisappear(): void {
    this.controller1 = undefined;
    this.controller2 = undefined;
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.underline_style_horizontal_label'),
        this.breakpointModel.getValue(PADDING_28VP, PADDING_28VP, PADDING_36VP))
      Tabs({ barPosition: BarPosition.Start, controller: this.controller1 }) {
        TabContent() {
        }
        .tabBar(SubTabBarStyle.of($r('app.string.sub_tab_label')))

        TabContent() {
        }
        .tabBar(SubTabBarStyle.of($r('app.string.sub_tab_label')))
      }
      .vertical(false)
      .height(SIZE_NUM_56)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .barMode(BarMode.Scrollable)

      subTitleBuilder($r('app.string.underline_style_vertical_label'),
        this.breakpointModel.getValue(PADDING_28VP, PADDING_28VP, PADDING_36VP))
      Tabs({ barPosition: BarPosition.Start, controller: this.controller2, index: this.currentIndex }) {
        TabContent() {
        }
        .tabBar(this.UnderlineStyleTabBuilder(0, $r('app.string.sub_tab_one_label')))

        TabContent() {
        }
        .tabBar(this.UnderlineStyleTabBuilder(1, $r('app.string.sub_tab_two_label')))

        TabContent() {
        }
        .tabBar(this.UnderlineStyleTabBuilder(2, $r('app.string.sub_tab_three_label')))

        TabContent() {
        }
        .tabBar(this.UnderlineStyleTabBuilder(3, $r('app.string.sub_tab_four_label')))

        TabContent() {
        }
        .tabBar(this.UnderlineStyleTabBuilder(4, $r('app.string.sub_tab_five_label')))
      }
      .vertical(true)
      .barWidth(SIZE_NUM_96)
      .height(SIZE_NUM_280)
      .animationDuration(DURATION_400)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.selectedIndex = index;
        this.currentIndex = index;
      })
      .onAnimationStart((index: number, targetIndex: number) => {
        if (index === targetIndex) {
          return;
        }
        this.selectedIndex = targetIndex;
      })
      // Resolves swipe gesture conflict between outer scroll container and inner tabs.
      .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer,
        _others: Array<GestureRecognizer>): GestureJudgeResult => {
        // Before the recognizer is about to succeed, set its enable state based on the current component status.
        hilog.info(0x00, 'UnderlineStyle', 'ets onGestureRecognizerJudgeBegin child')
        if (current) {
          const target = current.getEventTargetInfo();
          if (target && current.isBuiltIn() && current.getType() === GestureControl.GestureType.PAN_GESTURE) {
            hilog.info(0x00, 'UnderlineStyle', 'ets onGestureRecognizerJudgeBegin child PAN_GESTURE')
            const panEvent = event as PanGestureEvent;
            // When the inner Tabs reach the end of scrolling
            if (panEvent && panEvent.velocityY < 0 && this.selectedIndex === 4) {
              hilog.info(0x00, 'UnderlineStyle', 'ets onGestureRecognizerJudgeBegin child reject end')
              return GestureJudgeResult.REJECT;
            }
            // When the inner Tabs reach the beginning of scrolling
            if (panEvent && panEvent.velocityY > 0 && this.selectedIndex === 0) {
              hilog.info(0x00, 'UnderlineStyle', 'ets onGestureRecognizerJudgeBegin child reject begin')
              return GestureJudgeResult.REJECT;
            }
          }
        }
        return GestureJudgeResult.CONTINUE;
      }, true)
    }
  }
}