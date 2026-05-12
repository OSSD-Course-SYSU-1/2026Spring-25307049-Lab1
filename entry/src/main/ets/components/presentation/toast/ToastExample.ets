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
import { groupHeader } from '../../../builder/CustomBuilder';
import { TOAST_DATA } from '../../../constants/CommonConstants';
import { BreakpointModel } from '../../../model/BreakpointModel';
import { LengthMetrics } from '@kit.ArkUI';
import { SIZE_NUM_12, SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../designtoken/Size';
import { CORNER_RADIUS_16 } from '../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP, PADDING_24VP } from '../../../designtoken/Padding';

@Builder
export function ToastExampleBuilder() {
  ToastExample()
}

@ComponentV2
struct ToastExample {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();

  build() {
    NavDestination() {
      List() {
        Repeat(TOAST_DATA)
          .each((groupWrap) => {
            ListItemGroup({ header: groupHeader(groupWrap.item.title) }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Row() {
                      Text(itemWrap.item.name)
                        .fontColor($r('sys.color.font_primary'))
                        .fontSize($r('sys.float.Subtitle_M'))
                        .fontWeight(FontWeight.Medium)

                      SymbolGlyph($r('sys.symbol.chevron_right'))
                        .fontSize($r('sys.float.Title_M'))
                        .fontColor([$r('sys.color.icon_fourth')])
                    }
                    .borderRadius(CORNER_RADIUS_16)
                    .width(SIZE_PERCENT_100)
                    .height(SIZE_NUM_56)
                    .padding({ left: PADDING_12VP, right: PADDING_12VP })
                    .justifyContent(FlexAlign.SpaceBetween)
                    .stateStyles({
                      normal: {
                        .backgroundColor($r('sys.color.comp_background_list_card'))
                      },
                      pressed: {
                        .backgroundColor($r('app.color.list_item_pressed_color'))
                      }
                    })
                    .onClick(() => {
                      this.navPathStack.pushPath({ name: itemWrap.item.url.toString() });
                    })
                  }
                })
                .key((item) => item.id)
            }
            .divider({
              strokeWidth: SIZE_NUM_12,
              color: $r('sys.color.background_secondary'),
            })
          })
          .key((group) => group.id)
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .padding({
        left: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP),
        right: this.breakpointModel.getValue(PADDING_16VP, PADDING_16VP, PADDING_24VP)
      })
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.Header)
      .edgeEffect(EdgeEffect.Spring)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .title($r('app.string.toast_label'), {
      paddingStart: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP)),
      paddingEnd: this.breakpointModel.getValue(LengthMetrics.vp(PADDING_16VP), LengthMetrics.vp(PADDING_16VP),
        LengthMetrics.vp(PADDING_24VP))
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}