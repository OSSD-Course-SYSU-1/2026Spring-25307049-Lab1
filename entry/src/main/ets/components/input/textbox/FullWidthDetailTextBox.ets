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
import { TextBoxStorage } from './model/TextBoxStorage';
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { SIZE_PERCENT_100 } from '../../../designtoken/Size';
import { PADDING_8VP } from '../../../designtoken/Padding';

@Builder
export function FullWidthDetailTextBoxBuilder(_name: ResourceStr, param: TextBoxStorage) {
  FullWidthDetailTextBox({ storage: param })
}

@ComponentV2
export struct FullWidthDetailTextBox {
  @Require @Param storage: TextBoxStorage;
  @Local menuItems: NavigationMenuItem[] = [];
  private controller: TextAreaController = new TextAreaController();

  aboutToAppear(): void {
    this.menuItems.length = 0;
    this.menuItems.push(
      {
        value: 'menuItem',
        symbolIcon: new SymbolGlyphModifier($r('sys.symbol.checkmark')),
        action: () => {
          if (this.controller) {
            this.controller.stopEditing();
          }
        }
      }
    );
  }

  @Builder
  customNavDestinationTitle() {
    Column() {
      Text($r('app.string.full_width_text_box_label'))
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.time_label_1'))
        .fontColor($r('sys.color.font_secondary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
    .height(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: PADDING_8VP })
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          TextArea({
            text: this.storage.text!!,
            placeholder: $r('app.string.textarea_placeholder_label_1'),
            controller: this.controller
          })
            .placeholderFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Regular })
            .width(SIZE_PERCENT_100)
            .height(SIZE_PERCENT_100)
            .fontSize($r('sys.float.Body_L'))
            .fontColor($r('sys.color.font_primary'))
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              hilog.info(0x00, 'FullWidthDetailTextBox', `The content length of the input field is: ${value.length}`);
            })
        }
      }
      .scrollBar(BarState.Off)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .title(this.customNavDestinationTitle())
    .menus(this.menuItems)
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}