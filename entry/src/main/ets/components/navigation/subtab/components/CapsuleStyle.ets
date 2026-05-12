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
import { ChipGroup, ChipSize, IconGroupSuffix, SymbolGlyphModifier } from '@kit.ArkUI';
import { BreakpointModel } from '../../../../model/BreakpointModel';
import { CommonUtils } from '../../../../utils/CommonUtils';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { SPACE_0, SPACE_10, SPACE_16, SPACE_8 } from '../../../../designtoken/Space';
import { PADDING_10VP, PADDING_16VP, PADDING_24VP } from '../../../../designtoken/Padding';

@ComponentV2
export struct CapsuleStyle {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  @LocalBuilder
  ChipGroupSuffix(): void {
    IconGroupSuffix({
      items: [
        new SymbolGlyphModifier($r('sys.symbol.dot_grid_2x2'))
          .onClick(() => {
            CommonUtils.showToast('The dot button has been clicked currently.');
          })
      ]
    })
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.capsule_style_single_selection_label'))
      ChipGroup({
        items: [
          {
            label: { text: 'Tab Bar' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          }
        ],
        itemStyle: {
          size: ChipSize.NORMAL,
          backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
          fontColor: $r('sys.color.ohos_id_color_text_primary'),
          selectedBackgroundColor: $r('sys.color.ohos_id_color_emphasize'),
          selectedFontColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
        },
        multiple: false,
        chipGroupSpace: {
          itemSpace: SPACE_8,
          startSpace: SPACE_16,
          endSpace: SPACE_16
        },
        chipGroupPadding: {
          top: PADDING_10VP,
          bottom: PADDING_10VP
        },
        onChange: (activatedChipsIndex: Array<number>) => {
          hilog.info(0x00, 'CapsuleStyle', 'chips on clicked, activated index ' + activatedChipsIndex);
        },
      })

      subTitleBuilder($r('app.string.capsule_style_single_selection_right_side_icon_label'))
      ChipGroup({
        items: [
          {
            label: { text: 'Tab Bar' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
        ],
        itemStyle: {
          size: ChipSize.NORMAL,
          backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
          fontColor: $r('sys.color.ohos_id_color_text_primary'),
          selectedBackgroundColor: $r('sys.color.ohos_id_color_emphasize'),
          selectedFontColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
        },
        multiple: false,
        chipGroupSpace: {
          itemSpace: SPACE_8,
          endSpace: SPACE_0
        },
        chipGroupPadding: {
          top: PADDING_10VP,
          bottom: PADDING_10VP
        },
        onChange: (activatedChipsIndex: Array<number>) => {
          hilog.info(0x00, 'CapsuleStyle', 'chips on clicked, activated index ' + activatedChipsIndex);
        },
        suffix: this.ChipGroupSuffix
      })

      subTitleBuilder($r('app.string.capsule_style_multiple_choice_label'))
      ChipGroup({
        items: [
          {
            label: { text: 'Select One' },
            allowClose: false
          },
          {
            label: { text: 'Select Two' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          },
          {
            label: { text: 'Title' },
            allowClose: false
          }
        ],
        itemStyle: {
          size: ChipSize.NORMAL,
          backgroundColor: $r('sys.color.ohos_id_color_button_normal'),
          fontColor: $r('sys.color.ohos_id_color_text_primary'),
          selectedBackgroundColor: $r('sys.color.ohos_id_color_emphasize'),
          selectedFontColor: $r('sys.color.ohos_id_color_text_primary_contrary'),
        },
        selectedIndexes: [0, 1],
        multiple: true,
        chipGroupSpace: {
          itemSpace: SPACE_8,
          startSpace: SPACE_16,
          endSpace: SPACE_16
        },
        chipGroupPadding: {
          top: SPACE_10,
          bottom: SPACE_10
        },
        onChange: (activatedChipsIndex: Array<number>) => {
          hilog.info(0x00, 'CapsuleStyle', 'chips on clicked, activated index ' + activatedChipsIndex);
        },
      })
    }
    .padding({
      left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
      right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
    })
  }
}