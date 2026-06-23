/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 */

import { groupHeader, noMore } from '../builder/CustomBuilder';
import { COMPONENT_DATA } from '../constants/CommonConstants';
import { BreakpointModel } from '../model/BreakpointModel';
import { KeyboardAvoidMode, LengthMetrics } from '@kit.ArkUI';
import { PADDING_16VP, PADDING_4VP, PADDING_8VP } from '../designtoken/Padding';
import { SPACE_12 } from '../designtoken/Space';
import { CORNER_RADIUS_12, CORNER_RADIUS_16 } from '../designtoken/CornerRadius';
import { SIZE_NUM_12, SIZE_NUM_56, SIZE_PERCENT_100, SIZE_PERCENT_40 } from '../designtoken/Size';

// --- 【修复点 1】：显式定义数据接口，解决 arkts-no-untyped-obj-literals 错误 ---
interface ComponentItem {
  id: string;
  name: ResourceStr;
  url: ResourceStr;
}

interface ComponentGroup {
  id: string;
  title: ResourceStr;
  items: Array<ComponentItem>;
}

@Entry
@ComponentV2
struct Index {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  @Local selectedIndex: string = '';
  @Local searchText: string = '';
  @Provider('navPathStack') private navPathStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
  }

  // --- 【修复点 2】：增加返回类型 Array<ComponentGroup>，解决 return type inference 错误 ---
  getFilteredData(): Array<ComponentGroup> {
    const keyword = this.searchText.trim().toLowerCase();
    if (keyword === '') {
      return COMPONENT_DATA as Array<ComponentGroup>;
    }

    const result: Array<ComponentGroup> = [];

    COMPONENT_DATA.forEach((group) => {
      const filteredItems = group.items.filter((item: ComponentItem) => {
        // --- 【修复点 3】：处理 ResourceStr 转字符串，解决 toLowerCase 错误 ---
        const nameStr = typeof item.name === 'string' ? item.name : getContext().resourceManager.getStringSync((item.name as Resource).id);
        return nameStr.toLowerCase().includes(keyword);
      });

      if (filteredItems.length > 0) {
        result.push({
          id: group.id,
          title: group.title,
          items: filteredItems
        });
      }
    });

    return result;
  }

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Search({ placeholder: '搜索组件...', value: this.searchText })
          .width(SIZE_PERCENT_100)
          .height(48)
          .padding({ left: PADDING_16VP, right: PADDING_16VP })
          .margin({ top: PADDING_8VP, bottom: PADDING_8VP })
          .onChange((value: string) => {
            this.searchText = value;
          })

        List({ space: SPACE_12 }) {
          Repeat(this.getFilteredData())
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
        // --- 【修复点 4】：初始化 List 宽高，解决编译警告 ---
        .width(SIZE_PERCENT_100)
        .height(SIZE_PERCENT_100)
        .layoutWeight(1)
        .padding({
          left: PADDING_16VP,
          right: PADDING_16VP
        })
        .scrollBar(BarState.Off)
        .sticky(StickyStyle.Header)
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_PERCENT_100)
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height(SIZE_PERCENT_100)
    .width(SIZE_PERCENT_100)
    .title($r('app.string.index_title'), {
      paddingStart: LengthMetrics.vp(PADDING_16VP),
      paddingEnd: LengthMetrics.vp(PADDING_16VP)
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .backgroundImage($r('app.media.background_photo'))
    .backgroundImageSize(ImageSize.Cover)
    .mode(this.breakpointModel.currentNavigationMode)
    .navBarWidth(SIZE_PERCENT_40)
  }
}