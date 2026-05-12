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
import { display, window } from '@kit.ArkUI';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { WindowUtil } from '../../../utils/WindowUtil';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { SIZE_PERCENT_100 } from '../../../designtoken/Size';
import { PADDING_16VP } from '../../../designtoken/Padding';

@Builder
export function LandscapeBindSheetExampleBuilder() {
  LandscapeBindSheetExample()
}

@ComponentV2
export struct LandscapeBindSheetExample {
  @Local isShowLandscapeModalBuilder: boolean = false;
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private winUtil: WindowUtil | undefined = WindowUtil.getInstance();

  @Builder
  myBuilder() {
    Column() {
      Column() {
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .backgroundColor($r('app.color.bindSheet_content_background_color'))
    }
    .margin({
      left: PADDING_16VP,
      right: PADDING_16VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }

  aboutToAppear(): void {
    this.isShowLandscapeModalBuilder = true;
    if (['xs', 'sm'].includes(this.breakpointModel.currentWidthBreakpoint)) {
      this.winUtil?.setMainWindowOrientation(window.Orientation.LANDSCAPE);
    }
    this.breakpointModel.currentNavigationMode = NavigationMode.Stack;
    try {
      display.on('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      hilog.error(0x00, 'LeftRightLayoutTabBar',
        `Failed to register the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
  }

  aboutToDisappear(): void {
    this.winUtil?.setMainWindowOrientation(window.Orientation.PORTRAIT);
    this.breakpointModel.currentNavigationMode = NavigationMode.Auto;
    try {
      display.off('foldStatusChange', this.foldStatusChangeCallback);
    } catch (error) {
      hilog.error(0x00, 'LeftRightLayoutTabBar',
        `Failed to unregister the callback for fold status changes, error info:${JSON.stringify(error)}`);
    }
  }

  build() {
    NavDestination() {
      Column() {
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .onClick(() => {
        this.isShowLandscapeModalBuilder = true;
      })
      .bindSheet(this.isShowLandscapeModalBuilder!!, this.myBuilder(), {
        detents: [SheetSize.LARGE],
        blurStyle: BlurStyle.Thick,
        showClose: true,
        title: { title: $r('app.string.title_label') },
        enableOutsideInteractive: false
      })
    }
    .title($r('app.string.bind_sheet_in_landscape_mode_label'))
    .backgroundColor($r('sys.color.background_secondary'))
  }

  private foldStatusChangeCallback: Callback<display.FoldStatus> = (status: display.FoldStatus) => {
    switch (status) {
      case display.FoldStatus.FOLD_STATUS_EXPANDED:
      case display.FoldStatus.FOLD_STATUS_EXPANDED_WITH_SECOND_EXPANDED:
      case display.FoldStatus.FOLD_STATUS_FOLDED_WITH_SECOND_EXPANDED:
        this.navPathStack.pop();
        break;
      default:
        break;
    }
  };
}