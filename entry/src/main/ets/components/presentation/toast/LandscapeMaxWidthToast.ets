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
import { PromptAction, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { WindowUtil } from '../../../utils/WindowUtil';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { DURATION_3000 } from '../../../constants/CommonConstants';
import { PADDING_8VP } from '../../../designtoken/Padding';
import { SIZE_PERCENT_100 } from '../../../designtoken/Size';

@Builder
export function LandscapeMaxWidthToastBuilder() {
  LandscapeMaxWidthToast();
}

@ComponentV2
struct LandscapeMaxWidthToast {
  @Local toastId: number = -1;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private promptAction: PromptAction | undefined = undefined;
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();

  aboutToAppear(): void {
    this.promptAction = this.getUIContext().getPromptAction();
    if (['xs', 'sm'].includes(this.breakpointModel.currentWidthBreakpoint)) {
      this.winUtil?.setMainWindowOrientation(window.Orientation.LANDSCAPE);
    }
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    this.promptAction.openToast({
      message: 'A'.repeat(100),
      duration: DURATION_3000
    }).then((toastId: number) => {
      this.toastId = toastId;
    }).catch((err: BusinessError) => {
      hilog.error(0x00, 'LandscapeMaxWidthToast',
        `Failed to open the toast dialog, error code is ${err.code}, message is ${err.message}}`);
    })
  }

  aboutToDisappear(): void {
    try {
      if (this.toastId !== -1) {
        this.promptAction?.closeToast(this.toastId);
        this.toastId = -1;
      }
    } catch (err) {
      hilog.error(0x00, 'LandscapeMaxWidthToast', `Failed to close the toast dialog, error info:${JSON.stringify(err)}`)
    }
    this.promptAction = undefined;
    this.winUtil?.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text('Toast')
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.max_width_in_landscape_mode_label'))
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: PADDING_8VP })
  }

  build() {
    NavDestination() {
    }
    .title(this.customNavDestinationTitle())
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}