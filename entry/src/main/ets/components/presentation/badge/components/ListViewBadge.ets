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
import { subTitleBuilder } from '../../../../builder/CustomBuilder';
import { INTEGER_1, LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP, PADDING_4VP } from '../../../../designtoken/Padding';
import {
  SIZE_NUM_1,
  SIZE_NUM_12,
  SIZE_NUM_24,
  SIZE_NUM_40,
  SIZE_NUM_48,
  SIZE_NUM_6,
  SIZE_NUM_60,
  SIZE_NUM_63,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';

@Builder
export function ListViewBadge() {
  Column() {
    subTitleBuilder($r('app.string.list_style_label'))

    Column() {
      Row() {
        Badge({
          count: INTEGER_1,
          position: BadgePosition.Right,
          style: { badgeColor: $r('sys.color.warning') }
        }) {
          Text($r('app.string.single_list_1_label'))
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(LAYOUT_WEIGHT_1)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .width(SIZE_NUM_12)
          .height(SIZE_NUM_24)
          .margin({ left: PADDING_4VP })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(SIZE_NUM_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Text($r('app.string.single_list_2_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_48)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SIZE_PERCENT_100)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_4VP,
      bottom: PADDING_4VP
    })
    .margin({ bottom: PADDING_12VP })

    Column() {
      Row() {
        Row() {
          Image($r('app.media.avatar1'))
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .margin({ right: PADDING_16VP })

          Column() {
            Badge({
              value: '',
              position: BadgePosition.Right,
              style: {
                badgeSize: SIZE_NUM_6,
                badgeColor: $r('sys.color.warning')
              }
            }) {
              Text($r('app.string.evelyn_label'))
                .fontColor($r('sys.color.font_primary'))
                .fontSize($r('sys.float.Subtitle_M'))
                .fontWeight(FontWeight.Medium)
                .width(SIZE_NUM_60)
            }

            Text($r('app.string.auxiliary_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Body_M'))
              .fontWeight(FontWeight.Regular)
          }
          .alignItems(HorizontalAlign.Start)
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .width(SIZE_NUM_12)
          .height(SIZE_NUM_24)
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_63)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .strokeWidth(LAYOUT_WEIGHT_1)
        .color($r('sys.color.comp_background_tertiary'))

      Row() {
        Row() {
          Image($r('app.media.avatar2'))
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .margin({ right: PADDING_16VP })

          Column() {
            Text($r('app.string.marcia_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Subtitle_M'))
              .fontWeight(FontWeight.Medium)

            Text($r('app.string.auxiliary_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Body_M'))
              .fontWeight(FontWeight.Regular)
          }
          .alignItems(HorizontalAlign.Start)
        }

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
          .width(SIZE_NUM_12)
          .height(SIZE_NUM_24)
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_63)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(SIZE_PERCENT_100)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_4VP,
      bottom: PADDING_4VP
    })
  }
  .width(SIZE_PERCENT_100)
}