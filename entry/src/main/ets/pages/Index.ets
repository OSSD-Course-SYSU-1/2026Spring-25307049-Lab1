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

import { groupHeader, noMore } from '../builder/CustomBuilder';
import { COMPONENT_DATA } from '../constants/CommonConstants';
import { BreakpointModel } from '../model/BreakpointModel';
import { KeyboardAvoidMode, LengthMetrics } from '@kit.ArkUI';
import { PADDING_16VP, PADDING_4VP, PADDING_8VP } from '../designtoken/Padding';
import { SPACE_12 } from '../designtoken/Space';
import { CORNER_RADIUS_12, CORNER_RADIUS_16 } from '../designtoken/CornerRadius';
import { SIZE_NUM_12, SIZE_NUM_56, SIZE_PERCENT_100, SIZE_PERCENT_40 } from '../designtoken/Size';

@Entry
@ComponentV2
struct Index {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local selectedIndex: string = '';
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
  }

  build() {
    Navigation(this.navPathStack) {
      List({ space: SPACE_12 }) {
        Repeat(COMPONENT_DATA)
          .each((groupWrap) => {
            ListItemGroup({ header: groupHeader(groupWrap.item.title) }) {
              Repeat(groupWrap.item.items)
                .each((itemWrap) => {
                  ListItem() {
                    Column() {
                      Row() {
                        Text(itemWrap.item.name)
                          .fontColor($r('sys.color.font_primary'))
                          .fontSize($r('sys.float.Subtitle_M'))
                          .fontWeight(FontWeight.Medium)

                        SymbolGlyph($r('sys.symbol.chevron_right'))
                          .fontSize($r('sys.float.Title_M'))
                          .fontColor([$r('sys.color.icon_fourth')])
                      }
                      .justifyContent(FlexAlign.SpaceBetween)
                      .borderRadius(CORNER_RADIUS_12)
                      .width(SIZE_PERCENT_100)
                      .height(SIZE_PERCENT_100)
                      .padding({ left: PADDING_8VP, right: PADDING_8VP })
                      .backgroundColor((this.selectedIndex === `${groupWrap.index}_${itemWrap.index}` &&
                      ['md', 'lg'].includes(this.breakpointModel.currentWidthBreakpoint)) &&
                        this.navPathStack.size() !== 0 ?
                        $r('app.color.list_item_selected_color') : Color.Transparent)
                      .stateStyles({
                        pressed: {
                          .backgroundColor($r('app.color.list_item_pressed_color'))
                        }
                      })
                    }
                    .width(SIZE_PERCENT_100)
                    .height(SIZE_NUM_56)
                    .padding(PADDING_4VP)
                    .borderRadius(CORNER_RADIUS_16)
                    .backgroundColor($r('sys.color.comp_background_list_card'))
                    .onClick(() => {
                      if (['md', 'lg'].includes(this.breakpointModel.currentWidthBreakpoint)) {
                        if (this.selectedIndex !== `${groupWrap.index}_${itemWrap.index}` ||
                          this.navPathStack.size() === 0) {
                          this.navPathStack.replacePath({ name: itemWrap.item.url.toString() });
                        }
                      } else {
                        this.navPathStack.replacePath({ name: itemWrap.item.url.toString() });
                      }
                      this.selectedIndex = groupWrap.index + '_' + itemWrap.index;
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

        ListItem() {
          noMore();
        }
        .padding({
          left: $r('sys.float.padding_level8'),
          right: $r('sys.float.padding_level8')
        })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
      .padding({
        left: PADDING_16VP,
        right: PADDING_16VP
      })
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.Header)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height(SIZE_PERCENT_100)
    .width(SIZE_PERCENT_100)
    .title($r('app.string.index_title'), {
      paddingStart: LengthMetrics.vp(PADDING_16VP),
      paddingEnd: LengthMetrics.vp(PADDING_16VP)
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .mode(this.breakpointModel.currentNavigationMode)
    .navBarWidth(SIZE_PERCENT_40)
  }
}