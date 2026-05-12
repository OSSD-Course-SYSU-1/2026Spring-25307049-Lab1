/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { WindowUtil } from '../utils/WindowUtil';

const DOMAIN = 0x0000;
const TAG = 'EntryAbility';

export default class EntryAbility extends UIAbility {
  private windowObj?: window.Window;
  private windowUtil?: WindowUtil = WindowUtil.getInstance();

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, TAG, 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageCreate');

    if (this.windowUtil) {
      this.windowUtil.setWindowStage(windowStage);
    }

    windowStage.getMainWindow().then((data: window.Window) => {
      this.windowObj = data;
      this.windowObj.on('windowSizeChange', this.onWindowSizeChange);
      try {
        const windowRect = data.getWindowProperties().windowRect;
        this.onWindowSizeChange({ width: windowRect.width, height: windowRect.height });
      } catch (error) {
        hilog.error(DOMAIN, TAG, `getWindowProperties failed, error info: ${JSON.stringify(error)}`);
      }
    }).catch((error: BusinessError) => {
      hilog.error(DOMAIN, TAG, `Failed to obtain the main window, error info: ${JSON.stringify(error)}`);
    });

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, TAG, 'Succeeded in loading the content.');
    });
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    this.windowObj?.off('windowSizeChange', this.onWindowSizeChange);
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onBackground');
  }

  private onWindowSizeChange: (windowSize: window.Size) => void = (windowSize: window.Size) => {
    if (this.windowUtil) {
      this.windowUtil.updateHeightBp();
      this.windowUtil.updateWidthBp();
      this.windowUtil.updateWindowWidth(windowSize.width);
      this.windowUtil.updateWindowHeight(windowSize.height);
    }
  };
}