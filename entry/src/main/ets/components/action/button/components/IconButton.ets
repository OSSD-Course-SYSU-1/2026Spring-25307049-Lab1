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
import { CORNER_RADIUS_20 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_19, SIZE_NUM_40, SIZE_NUM_60, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { SPACE_16, SPACE_2, SPACE_8 } from '../../../../designtoken/Space';
import { BreakpointModel } from '../../../../model/BreakpointModel';
import { CommonUtils } from '../../../../utils/CommonUtils';

@ComponentV2
export struct IconButton {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    Column() {
      subTitleBuilder($r('app.string.icon_button_label'))
      Column({ space: SPACE_16 }) {
        Text($r('app.string.button_type_or_normal_label'))
          .fontSize($r('sys.float.Subtitle_S'))
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight(SIZE_NUM_19)
          .fontWeight(FontWeight.Medium)
          .width(SIZE_PERCENT_100)
          .margin({ top: PADDING_12VP })

        Flex({
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_on_primary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)

            Text($r('app.string.emphasize_the_background_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)
          .onClick(() => {
            CommonUtils.showToast($r('app.string.emphasize_the_background_label'));
          })

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.NORMAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)

            Text($r('app.string.plain_background_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)
          .onClick(() => {
            CommonUtils.showToast($r('app.string.plain_background_label'));
          })

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)

            Text($r('app.string.icon_only_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)
          .onClick(() => {
            CommonUtils.showToast($r('app.string.icon_only_label'));
          })

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              Column({ space: SPACE_2 }) {
                SymbolGlyph($r('sys.symbol.bell'))
                  .fontColor([$r('sys.color.icon_secondary')])
                  .fontSize($r('sys.float.Title_M'))
                Text('Text')
                  .fontColor($r('sys.color.font_secondary'))
                  .fontSize($r('sys.float.Body_S'))
              }
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)

            Text($r('app.string.with_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)
          .onClick(() => {
            CommonUtils.showToast($r('app.string.with_text_label'));
          })
        }

        Text($r('app.string.disabled_status_label'))
          .fontSize($r('sys.float.Subtitle_S'))
          .fontColor($r('sys.color.font_secondary'))
          .lineHeight(SIZE_NUM_19)
          .fontWeight(FontWeight.Medium)
          .width(SIZE_PERCENT_100)
          .margin({ top: PADDING_12VP })

        Flex({
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_on_primary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.EMPHASIZED)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.emphasize_the_background_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.NORMAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.plain_background_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              SymbolGlyph($r('sys.symbol.bell'))
                .fontColor([$r('sys.color.icon_secondary')])
                .fontSize($r('sys.float.Title_M'))
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.icon_only_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)

          Column({ space: SPACE_8 }) {
            Button({ type: ButtonType.Circle }) {
              Column({ space: SPACE_2 }) {
                SymbolGlyph($r('sys.symbol.bell'))
                  .fontColor([$r('sys.color.icon_secondary')])
                  .fontSize($r('sys.float.Title_M'))
                Text('Text')
                  .fontColor($r('sys.color.font_secondary'))
                  .fontSize($r('sys.float.Body_S'))
              }
            }
            .buttonStyle(ButtonStyleMode.TEXTUAL)
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .stateEffect(false)
            .hoverEffect(HoverEffect.None)
            .enabled(false)

            Text($r('app.string.with_text_label'))
              .fontColor($r('sys.color.font_secondary'))
              .fontSize($r('sys.float.Subtitle_S'))
              .lineHeight(SIZE_NUM_19)
          }
          .width(SIZE_NUM_60)
        }
      }
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .borderRadius(CORNER_RADIUS_20)
      .padding({
        left: this.breakpointModel.getValue(PADDING_12VP, PADDING_16VP, PADDING_16VP),
        right: this.breakpointModel.getValue(PADDING_12VP, PADDING_16VP, PADDING_16VP),
        top: PADDING_16VP,
        bottom: PADDING_16VP
      })
    }
  }
}