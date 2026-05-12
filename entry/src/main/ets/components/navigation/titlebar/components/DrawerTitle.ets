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
import { HdsNavDestination, HdsNavDestinationTitleMode } from '@kit.UIDesignKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PADDING_28VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56 } from '../../../../designtoken/Size';

@Builder
export function DrawerTitle() {
  Column() {
    subTitleBuilder($r('app.string.drawer_style_title_bar_label'), PADDING_28VP)
    HdsNavDestination()
      .height(SIZE_NUM_56)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .titleMode(HdsNavDestinationTitleMode.MINI)
      .titleBar({
        content: {
          title: {
            mainTitle: 'Title'
          },
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'DrawerTitle', 'HdsNavDestination menu1');
                }
              }
            }]
          },
          subIcon: {
            content: {
              label: 'subIcon',
              icon: $r('sys.symbol.close_sidebar'),
              isEnabled: true,
              action: () => {
                hilog.info(0x00, 'DrawerTitle', 'HdsNavDestination subIcon');
              }
            }
          }
        }
      })
      .hideBackButton(true)
  }
}