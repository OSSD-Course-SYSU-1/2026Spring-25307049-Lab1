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
import { LOADING_PROGRESS_EXAMPLE_NAME } from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_4VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_24, SIZE_NUM_48, SIZE_PERCENT_100 } from '../../../../designtoken/Size';

@ComponentV2
export struct LoadingStyleProgress {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();

  build() {
    Column() {
      subTitleBuilder($r('app.string.no_clear_progress_bar_label'))

      Column() {
        Row() {
          Text($r('app.string.for_component_combination_scenarios_label'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          LoadingProgress()
            .width(SIZE_NUM_24)
            .height(SIZE_NUM_24)
            .color($r('sys.color.icon_tertiary'))
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Divider()

        Row() {
          Text($r('app.string.for_full_page_loading_scenarios_label'))
            .fontSize($r('sys.float.Subtitle_M'))
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)

          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_fourth')])
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.navPathStack.pushPath({ name: LOADING_PROGRESS_EXAMPLE_NAME });
        })
      }
      .width(SIZE_PERCENT_100)
      .justifyContent(FlexAlign.SpaceBetween)
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
}