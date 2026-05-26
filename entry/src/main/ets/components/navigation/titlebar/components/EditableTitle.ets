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
import { EditableLeftIconType, EditableTitleBar } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PADDING_28VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56 } from '../../../../designtoken/Size';

@Builder
export function EditableTitle() {
  Column() {
    subTitleBuilder($r('app.string.edit_page_title_bar_label'), PADDING_28VP)
    EditableTitleBar({
      leftIconStyle: EditableLeftIconType.Cancel,
      title: $r('app.string.edit_label'),
      menuItems: [],
      imageItem: {
        value: '',
        isEnabled: true
      },
      onSave: () => {
        hilog.info(0x00, 'EditableTitle', 'The save has been clicked currently.');
      }
    })
      .height(SIZE_NUM_56)
      .backgroundColor($r('sys.color.comp_background_list_card'))
  }
}