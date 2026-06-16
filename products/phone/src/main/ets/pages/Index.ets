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

import { window } from '@kit.ArkUI';
import { CommonConstants, Logger, WindowUtil } from '@ohos/commons/Index';
import { ContinuationManager, ContinuationState, CONTINUATION_STATE_KEY, CURRENT_PRODUCT_ID_KEY } from '@ohos/commons/Index';
import { ReceiveNotification } from '@ohos/commons/Index';
import { DetailConstants, ProductHome } from '@ohos/detail/Index';
import { ProductMoreDetail } from '@ohos/detail/Index';
import { LiveHome } from '@ohos/detail/Index';
import { Home, SearchView } from '@ohos/home/Index';
import { ClassifyConstants } from '@ohos/home/Index';

@Entry
@Component
struct Index {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @StorageLink('isSplitMode') isSplitMode: boolean = false;
  @StorageLink(CONTINUATION_STATE_KEY) continuationState: ContinuationState | undefined = undefined;
  private windowUtil?: WindowUtil;
  private mainWindow?: window.Window;
  private continuationManager: ContinuationManager = ContinuationManager.getInstance();
  private hasConsumedContinuation: boolean = false;

  aboutToAppear(): void {
    if (this.isSplitMode) {
      this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[2] })
    }

    // Handle continuation (自由流转) state restore
    if (this.continuationState && !this.hasConsumedContinuation) {
      this.hasConsumedContinuation = true;
      const tabIndex: number = this.continuationState.currentTabIndex;
      const page: string = this.continuationState.currentPage;
      const productId: string = this.continuationState.browsingProductId;
      const searchKeyword: string = this.continuationState.searchKeyword;
      Logger.info(`Index: Restoring continuation state - tab=${tabIndex}, page=${page}`);

      // Signal Home component to switch to the restored tab
      AppStorage.setOrCreate('continuationTabIndex', tabIndex);

      // Pre-set product ID so ProductHome loads the correct product on restore
      if (productId.length > 0) {
        AppStorage.setOrCreate(CURRENT_PRODUCT_ID_KEY, productId);
      }

      // Pre-set search keyword for SearchView to consume
      if (searchKeyword.length > 0) {
        AppStorage.setOrCreate('continuationSearchKeyword', searchKeyword);
      }

      // Navigate to the restored page after Navigation tree is ready
      if (page.length > 0 && page !== 'MineContent') {
        setTimeout(() => {
          this.navigateToPage(page);
        }, 150);
      }

      // Consume the state so it won't be re-processed
      this.continuationManager.consumeState();
    }
  }

  aboutToDisappear(): void {
    if (this.windowUtil === undefined) {
      return;
    }
    this.mainWindow = this.windowUtil.getMainWindow();
    if (this.mainWindow === undefined) {
      return;
    }
    try {
      this.mainWindow.off('windowSizeChange');
      if (canIUse('SystemCapability.Window.SessionManager')) {
        this.mainWindow.off('windowStatusChange');
      }
    } catch (exception) {
      Logger.error('Failed to unregister the window callback. Code: ' + JSON.stringify(exception));
    }
  }

  /**
   * Navigate to the specified page during continuation restore.
   */
  private navigateToPage(page: string): void {
    Logger.info(`Index: Navigating to restored page - ${page}`);
    if (page === 'ProductHome') {
      this.pageInfos.pushPathByName(ClassifyConstants.PAGE_INFO_LIST[2], undefined);
    } else if (page === 'SearchView') {
      this.pageInfos.pushPathByName('searchView', undefined);
    } else if (page === 'LiveHome') {
      this.pageInfos.pushPathByName(ClassifyConstants.PAGE_INFO_LIST[0], undefined);
    }
  }

  @Builder
  PageMap(name: string) {
    if (name === ClassifyConstants.PAGE_INFO_LIST[0]) {
      LiveHome()
    } else if (name === ClassifyConstants.PAGE_INFO_LIST[1]) {
      ProductMoreDetail()
    } else if (name === 'searchView') {
      SearchView()
    } else {
      ProductHome()
    }
  }

  build() {
    Stack() {
      Navigation(this.pageInfos) {
        Home()
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .navDestination(this.PageMap)
      .mode(NavigationMode.Stack)
      .id(DetailConstants.NAVIGATION_ID)
      .hideTitleBar(true)

      // Receive notification overlay for cross-device sharing (隔空投送)
      ReceiveNotification()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}