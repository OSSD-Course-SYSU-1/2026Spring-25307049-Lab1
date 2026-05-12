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
import {
  COLUMNS_TEMPLATE_4,
  FLOAT_0_POINT_5,
  INTEGER_1000,
  INTEGER_3,
  INTEGER_99
} from '../../../../constants/CommonConstants';
import { CORNER_RADIUS_16, CORNER_RADIUS_20 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP, PADDING_24VP, PADDING_2VP, PADDING_8VP } from '../../../../designtoken/Padding';
import {
  SIZE_NUM_14,
  SIZE_NUM_24,
  SIZE_NUM_36,
  SIZE_NUM_40,
  SIZE_NUM_48,
  SIZE_NUM_56,
  SIZE_NUM_6,
  SIZE_NUM_72,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { SPACE_2, SPACE_30, SPACE_32 } from '../../../../designtoken/Space';

@Builder
function firstStyleTabBuilder(index: number) {
  Column() {
    if (index === 2) {
      Badge({
        value: '',
        style: {
          badgeSize: SIZE_NUM_6,
          badgeColor: $r('sys.color.warning')
        }
      }) {
        SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor([$r('sys.color.icon_fourth')])
      }
      .width(SIZE_NUM_24)
      .height(SIZE_NUM_24)
      .margin({ bottom: PADDING_2VP })
    } else {
      SymbolGlyph($r('sys.symbol.person_crop_circle_fill_1'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor(index === 1 ? [$r('sys.color.icon_emphasize')] : [$r('sys.color.icon_fourth')])
    }
    Text($r('app.string.tab_label'))
      .fontSize($r('sys.float.Caption_M'))
      .fontColor(index === 1 ? $r('sys.color.font_emphasize') : $r('sys.color.font_secondary'))
      .lineHeight(SIZE_NUM_14)
      .fontWeight(FontWeight.Medium)
  }
  .width(SIZE_PERCENT_100)
  .height(SIZE_PERCENT_100)
  .justifyContent(FlexAlign.Center)
}

@Builder
function secondStyleTabBuilder(index: number, val: ResourceStr) {
  Column() {
    if (index === 2) {
      Badge({
        value: '',
        position: BadgePosition.Right,
        style: {
          badgeSize: SIZE_NUM_6,
          badgeColor: $r('sys.color.warning')
        }
      }) {
        Text(val)
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Regular)
          .width(SIZE_NUM_36)
      }
    } else {
      Text(val)
        .fontColor(index === 0 ? $r('sys.color.font_on_primary') : $r('sys.color.font_primary'))
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
    }
  }
  .width(SIZE_NUM_72)
  .height(SIZE_NUM_36)
  .justifyContent(FlexAlign.Center)
  .backgroundColor(index === 0 ? $r('sys.color.comp_background_emphasize') : $r('sys.color.comp_background_tertiary'))
  .borderRadius(CORNER_RADIUS_20)
  .margin({ right: PADDING_8VP })
}

@Builder
export function RecommendedStyleBadge() {
  Column() {
    subTitleBuilder($r('app.string.recommended_style_label'))

    Row() {
      Tabs() {
        TabContent() {
        }
        .tabBar(firstStyleTabBuilder(0))

        TabContent() {
        }
        .tabBar(firstStyleTabBuilder(1))

        TabContent() {
        }
        .tabBar(firstStyleTabBuilder(2))

        TabContent() {
        }
        .tabBar(firstStyleTabBuilder(3))
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_48)
      .backgroundColor($r('app.color.gray_08'))
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
    .margin({ bottom: PADDING_12VP })

    Row() {
      Tabs() {
        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(0, $r('app.string.tab_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(1, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(2, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(3, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(4, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(5, $r('app.string.title_label')))

        TabContent() {
        }
        .tabBar(secondStyleTabBuilder(6, $r('app.string.title_label')))
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .backgroundColor($r('app.color.gray_08'))
      .barMode(BarMode.Scrollable)
      .fadingEdge(false)
      .padding({
        left: PADDING_16VP,
        right: PADDING_8VP
      })
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding(PADDING_12VP)
    .margin({ bottom: PADDING_12VP })

    Row() {
      Grid() {
        GridItem() {
          Column({ space: SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.picture'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([Color.Black])
            }
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .borderWidth(FLOAT_0_POINT_5)
            .borderRadius(CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.picture_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.heart'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([Color.Black])
            }
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .borderWidth(FLOAT_0_POINT_5)
            .borderRadius(CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.collect_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Badge({
              value: '',
              position: BadgePosition.RightTop,
              style: { badgeSize: SIZE_NUM_6 }
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.music'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([Color.Black])
              }
              .width(SIZE_NUM_40)
              .height(SIZE_NUM_40)
              .borderWidth(FLOAT_0_POINT_5)
              .borderRadius(CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.music_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.mic'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([Color.Black])
            }
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .borderWidth(FLOAT_0_POINT_5)
            .borderRadius(CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.mic_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.picture'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([Color.Black])
            }
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .borderWidth(FLOAT_0_POINT_5)
            .borderRadius(CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.picture_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Badge({
              count: INTEGER_1000,
              maxCount: INTEGER_99,
              position: BadgePosition.RightTop,
              style: {}
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.heart'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([Color.Black])
              }
              .width(SIZE_NUM_40)
              .height(SIZE_NUM_40)
              .borderWidth(FLOAT_0_POINT_5)
              .borderRadius(CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.collect_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Badge({
              count: INTEGER_3,
              maxCount: INTEGER_99,
              position: BadgePosition.RightTop,
              style: {}
            }) {
              Row() {
                SymbolGlyph($r('sys.symbol.music'))
                  .fontSize($r('sys.float.Title_M'))
                  .fontColor([Color.Black])
              }
              .width(SIZE_NUM_40)
              .height(SIZE_NUM_40)
              .borderWidth(FLOAT_0_POINT_5)
              .borderRadius(CORNER_RADIUS_20)
              .borderColor($r('sys.color.gray_02'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
            }

            Text($r('app.string.music_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }

        GridItem() {
          Column({ space: SPACE_2 }) {
            Row() {
              SymbolGlyph($r('sys.symbol.mic'))
                .fontSize($r('sys.float.Title_M'))
                .fontColor([Color.Black])
            }
            .width(SIZE_NUM_40)
            .height(SIZE_NUM_40)
            .borderWidth(FLOAT_0_POINT_5)
            .borderRadius(CORNER_RADIUS_20)
            .borderColor($r('sys.color.gray_02'))
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text($r('app.string.mic_label'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
          }
        }
      }
      .rowsGap(SPACE_30)
      .columnsGap(SPACE_32)
      .columnsTemplate(COLUMNS_TEMPLATE_4)
      .padding({
        left: PADDING_24VP,
        right: PADDING_24VP
      })
    }
    .width(SIZE_PERCENT_100)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius(CORNER_RADIUS_16)
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP,
      top: PADDING_16VP,
      bottom: PADDING_16VP
    })
  }
  .width(SIZE_PERCENT_100)
}