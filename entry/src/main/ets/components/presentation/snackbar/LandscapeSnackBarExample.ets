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
import {
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarOperationType,
  SnackBarStyleOptions
} from '@kit.UIDesignKit';
import { ColorMetrics, window } from '@kit.ArkUI';
import { WindowUtil } from '../../../utils/WindowUtil';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { DURATION_NEGATIVE_1 } from '../../../constants/CommonConstants';
import { PADDING_16VP } from '../../../designtoken/Padding';

@Builder
export function LandscapeSnackBarExampleBuilder() {
  LandscapeSnackBarExample()
}

@ComponentV2
struct LandscapeSnackBarExample {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();
  private hdsSnackBar: HdsSnackBar | null = null;
  private curTitleColor: ColorMetrics | undefined = undefined;
  private message: SnackBarMessageOptions = {};
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
  };
  private operation: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_CLOSE,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton2',
    onContentClick: () => {
      hilog.info(0x00, 'LandscapeSnackBarExample', 'Content clicked.');
    }
  };
  private style: SnackBarStyleOptions = {
    duration: DURATION_NEGATIVE_1
  };

  aboutToAppear(): void {
    const uiContext: UIContext = this.getUIContext();
    this.hdsSnackBar = new HdsSnackBar(uiContext);
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    try {
      this.curTitleColor = ColorMetrics.resourceColor($r('sys.color.font_primary'));
    } catch (err) {
      hilog.error(0x00, 'LandscapeSnackBarExample', 'Failed to instantiate the ColorMetrics class using ResourceColor');
    }
    this.message = {
      title: $r('app.string.residency_label'),
      titleColor: this.curTitleColor
    };
    if (['xs', 'sm'].includes(this.breakpointModel.currentWidthBreakpoint)) {
      this.winUtil?.setMainWindowOrientation(window.Orientation.LANDSCAPE);
    }
    this.hdsSnackBar?.show(this.icon, this.message, this.operation, this.style);
  }

  aboutToDisappear(): void {
    this.hdsSnackBar?.dismiss();
    this.hdsSnackBar = null;
    this.winUtil?.setMainWindowOrientation(window.Orientation.FOLLOW_DESKTOP);
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
  }

  build() {
    NavDestination() {
      Column() {
      }
      .padding({
        left: PADDING_16VP,
        right: PADDING_16VP
      })
    }
    .title($r('app.string.snack_bar_in_landscape_mode_label'))
    .backgroundColor($r('sys.color.background_secondary'))
  }
}