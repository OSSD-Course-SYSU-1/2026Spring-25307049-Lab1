/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { CommonConstants, WindowUtil } from '@ohos/commons';
import { ContinuationManager } from '@ohos/commons';
import { ContinuationState } from '@ohos/commons';
import { ShareSessionManager } from '@ohos/commons';

export default class EntryAbility extends UIAbility {
  private windowObj?: window.Window;
  private windowUtil?: WindowUtil;
  private continuationManager: ContinuationManager = ContinuationManager.getInstance();
  private onWindowSizeChange: (windowSize: window.Size) => void = (windowSize: window.Size) => {
    this.windowUtil?.updateBreakpoint(windowSize.width);
    AppStorage.setOrCreate('windowWidth', windowSize.width);
  };
  private onWindowStatusChange: (windowStatusType: window.WindowStatusType) => void =
    (windowStatusType: window.WindowStatusType) => {
      this.windowUtil?.updateWindowStatusType(windowStatusType);
    };

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.windowUtil = WindowUtil.getInstance();
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // Initialize distributed share service for receiving AirDrop data
    const shareManager = ShareSessionManager.getInstance();
    shareManager.setContext(this.context);
    shareManager.startReceiving((payload: string) => {
      hilog.info(0x0000, 'EntryAbility', `AirDrop data received: ${payload.substring(0, 100)}...`);
      AppStorage.setOrCreate('received_share_data', payload);
      AppStorage.setOrCreate('show_receive_notification', true);
    });

    // Detect if this session was launched via continuation (自由流转)
    if (launchParam.launchReason === AbilityConstant.LaunchReason.CONTINUATION) {
      hilog.info(0x0000, 'testTag', 'Ability launched via CONTINUATION, restoring state...');
      const params = want.parameters as Record<string, Object>;
      if (params) {
        this.continuationManager.restoreFromParams(params);
      }
    }
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  /**
   * Called by the system when the user initiates cross-device continuation (自由流转).
   * Packages the current app state into wantParam for the target device to restore.
   */
  onContinue(wantParam: Record<string, Object>): AbilityConstant.OnContinueResult {
    hilog.info(0x0000, 'testTag', 'Ability onContinue — packaging state for cross-device migration');
    const state: ContinuationState = this.continuationManager.buildContinuationState();
    wantParam['currentTabIndex'] = state.currentTabIndex;
    wantParam['currentPage'] = state.currentPage;
    wantParam['browsingProductId'] = state.browsingProductId;
    wantParam['isLiveActive'] = state.isLiveActive;
    wantParam['searchKeyword'] = state.searchKeyword;
    wantParam['continuationTimestamp'] = state.timestamp;
    return AbilityConstant.OnContinueResult.AGREE;
  }

  /**
   * Called when the ability is re-launched while already running.
   * Handles continuation restore when the app is already alive.
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', 'Ability onNewWant');
    if (launchParam.launchReason === AbilityConstant.LaunchReason.CONTINUATION) {
      hilog.info(0x0000, 'testTag', 'onNewWant: continuation restore while app is alive');
      const params = want.parameters as Record<string, Object>;
      if (params) {
        this.continuationManager.restoreFromParams(params);
      }
    }
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.getMainWindow().then((data: window.Window) => {
      this.windowObj = data;
      this.windowUtil?.updateBreakpoint(this.windowObj.getWindowProperties().windowRect.width);
      AppStorage.setOrCreate('windowWidth', this.windowObj.getWindowProperties().windowRect.width);
      this.windowObj.on('windowSizeChange', this.onWindowSizeChange);
      if (canIUse('SystemCapability.Window.SessionManager')) {
        this.windowObj.on('windowStatusChange', this.onWindowStatusChange);
      }
    }).catch((err: BusinessError<Error>) => {
      hilog.info(0x0000, 'testTag', `Failed to getMainWindow. Cause: ${err.code}, message: ${err.message}`);
    });

    windowStage.loadContent('pages/Index', async (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
      if (this.windowUtil !== undefined) {
        this.windowUtil.setWindowStage(windowStage);
        await this.windowUtil.setMainWindow();
        if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
          this.windowUtil.setFullScreen();
        }
        this.windowUtil.setAvoidRectHeight(windowStage.getMainWindowSync().getUIContext());
      }
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}