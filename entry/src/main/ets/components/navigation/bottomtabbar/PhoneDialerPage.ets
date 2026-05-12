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
import { DIALER_DATA, KeyItem } from '../../../constants/CommonConstants';
import { CORNER_RADIUS_29 } from '../../../designtoken/CornerRadius';
import { PADDING_2VP } from '../../../designtoken/Padding';
import {
  SIZE_NUM_26,
  SIZE_NUM_300,
  SIZE_NUM_34,
  SIZE_NUM_58,
  SIZE_PERCENT_100,
  SIZE_PERCENT_80
} from '../../../designtoken/Size';
import { SPACE_12, SPACE_2, SPACE_24 } from '../../../designtoken/Space';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { CommonUtils } from '../../../utils/CommonUtils';

@Builder
export function PhoneDialerPageBuilder() {
  PhoneDialerPage()
}

@ComponentV2
struct PhoneDialerPage {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  /**
   * Constructs the view for a single key
   * @param item Key configuration data
   */
  @Builder
  keyItemBuilder(item: KeyItem, index: number) {
    Column({ space: SPACE_2 }) {
      if (typeof item.main === 'string') {
        Text(item.main)
          .fontSize(SIZE_NUM_26)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      } else {
        SymbolGlyph(item.main)
          .fontSize(SIZE_NUM_26)
          .fontColor([$r('sys.color.font_primary')])
          .margin({ bottom: PADDING_2VP })
      }

      if (index === 0 || index === 10) {
        SymbolGlyph(item.sub)
          .fontSize(index === 0 ? $r('sys.float.Body_M') : $r('sys.float.Caption_M'))
          .fontColor([$r('sys.color.font_tertiary')])
          .fontWeight(index === 0 ? FontWeight.Regular : FontWeight.Medium)
      } else {
        Text(item.sub)
          .fontSize($r('sys.float.Caption_M'))
          .fontColor($r('sys.color.font_tertiary'))
      }
    }
    .width(SIZE_NUM_58)
    .height(SIZE_NUM_58)
    .borderRadius(CORNER_RADIUS_29)
    .justifyContent(FlexAlign.Center)
    .stateStyles({
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      },
      normal: {
        .backgroundColor(Color.Transparent)
      }
    })
    .onClick(() => {
      let curButtonText: ResourceStr;
      switch (index) {
        case 9:
          curButtonText = '*';
          break;
        case 11:
          curButtonText = '#';
          break;
        default:
          curButtonText = item.main;
          break;
      }
      CommonUtils.showToast(`Button ${curButtonText} clicked.`);
    })
  }

  /**
   * Constructs the entire dial content
   */
  @Builder
  dialContentBuilder() {
    Grid() {
      ForEach(DIALER_DATA, (item: KeyItem, index: number) => {
        GridItem() {
          this.keyItemBuilder(item, index)
        }
      }, (item: KeyItem, index: number) => `${index}_${JSON.stringify(item)}`)
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(SPACE_12)
    .width(SIZE_PERCENT_80)
    .height(SIZE_NUM_300)
  }

  /**
   * Constructs the bottom green call button
   */
  @Builder
  callButtonBuilder() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      SymbolGlyph($r('sys.symbol.phone_fill'))
        .fontSize(SIZE_NUM_34)
        .fontColor([$r('sys.color.font_on_primary')])
    }
    .width(SIZE_NUM_58)
    .height(SIZE_NUM_58)
    .backgroundColor($r('sys.color.confirm'))
    .onClick(() => {
      CommonUtils.showToast('Initiate call.');
    })
  }

  build() {
    NavDestination() {
      Column({ space: SPACE_24 }) {
        this.dialContentBuilder()
        this.callButtonBuilder()
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}