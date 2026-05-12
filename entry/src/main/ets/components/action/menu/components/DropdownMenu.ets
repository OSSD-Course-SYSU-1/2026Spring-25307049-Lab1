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
import { LengthMetrics } from '@kit.ArkUI'
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius'
import { PADDING_12VP, PADDING_8VP } from '../../../../designtoken/Padding'
import { SIZE_NUM_1, SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size'

@Builder
function dropdownMenuBuilder() {
  Menu() {
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
    MenuItem({ content: $r('app.string.menu_item_label') })
  }
  .menuItemDivider({
    strokeWidth: LengthMetrics.vp(SIZE_NUM_1),
    color: $r('sys.color.comp_background_tertiary'),
    mode: DividerMode.EMBEDDED_IN_MENU
  })
}

@Builder
export function DropdownMenu() {
  ListItem() {
    Row() {
      Text($r('app.string.drop_down_menu_label'))
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))

      Blank()

      Row() {
        Text('Right text')
          .fontSize($r('sys.float.Subtitle_S'))
          .fontColor($r('sys.color.font_secondary'))
          .margin({ right: PADDING_8VP })

        SymbolGlyph($r('sys.symbol.arrowtriangle_down_fill'))
          .fontSize($r('sys.float.Body_L'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .bindMenu(dropdownMenuBuilder())
    }
    .borderRadius(CORNER_RADIUS_16)
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP
    })
    .backgroundColor($r('sys.color.comp_background_list_card'))
  }
}