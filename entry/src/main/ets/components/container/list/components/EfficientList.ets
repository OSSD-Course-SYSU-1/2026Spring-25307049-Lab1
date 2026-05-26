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
import { LengthMetrics } from '@kit.ArkUI';
import {
  HdsListItemCard,
  IconSize,
  PrefixIcon,
  SuffixImage,
  SuffixSubIcon,
  SuffixSwitch,
  SuffixText,
  SuffixTextAndArrow
} from '@kit.UIDesignKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import {
  SIZE_NUM_1,
  SIZE_NUM_104,
  SIZE_NUM_56,
  SIZE_NUM_636,
  SIZE_NUM_64,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { SPACE_12 } from '../../../../designtoken/Space';
import { PADDING_12VP, PADDING_40VP, PADDING_6VP, PADDING_8VP } from '../../../../designtoken/Padding';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { INTEGER_0 } from '../../../../constants/CommonConstants';

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

@ComponentV2
export struct EfficientList {
  @Local isRadioChecked: boolean = false;

  build() {
    Column() {
      subTitleBuilder($r('app.string.efficiency_oriented_list_label'))
      List({ space: SPACE_12 }) {
        ListItemGroup() {
          ListItem() {
            Row() {
              Text($r('app.string.single_line_list_and_drop_down_options_label'))
                .fontSize($r('sys.float.Body_L'))
                .fontWeight(FontWeight.Medium)
                .fontColor($r('sys.color.font_primary'))

              Blank()

              Row() {
                Text($r('app.string.drop_down_options_label'))
                  .fontSize($r('sys.float.Subtitle_S'))
                  .fontColor($r('sys.color.font_secondary'))
                  .margin({ right: PADDING_8VP })

                SymbolGlyph($r('sys.symbol.arrowtriangle_down_fill'))
                  .fontSize($r('sys.float.Body_L'))
                  .fontColor([$r('sys.color.icon_fourth')])
              }
              .bindMenu(dropdownMenuBuilder())
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_56)
          }

          ListItem() {
            Row() {
              Text($r('app.string.right_side_checkbox_label'))
                .fontSize($r('sys.float.Body_L'))
                .fontWeight(FontWeight.Medium)
                .fontColor($r('sys.color.font_primary'))

              Blank()

              Radio({ value: 'Radio', group: 'radioGroup' })
                .checked(this.isRadioChecked)
                .onClick(() => {
                  this.isRadioChecked = !this.isRadioChecked;
                })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_56)
          }
        }
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_12VP,
          right: PADDING_12VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .divider({
          strokeWidth: SIZE_NUM_1,
          color: $r('sys.color.comp_background_tertiary'),
        })

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: {
                    text: $r('app.string.double_line_list_and_switch_label')
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  },
                },
                suffixItem: new SuffixSwitch({
                  isCheck: false,
                  onChange: (isOn: boolean) => {
                    hilog.info(0x00, 'EfficientList', `Current toggle isSelected status: ${isOn}`);
                  },
                }),
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_64)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: {
                    text: $r('app.string.right_side_image_label')
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  },
                },
                suffixItem: new SuffixImage({
                  image: $r('app.media.img_1'),
                }),
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_64)
          }
        }
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .divider({
          strokeWidth: SIZE_NUM_1,
          startMargin: PADDING_6VP,
          endMargin: PADDING_6VP,
          color: $r('sys.color.comp_background_tertiary'),
        })

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                textItem: {
                  primaryText: {
                    text: $r('app.string.three_line_list_label'),
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  },
                  description: {
                    text: $r('app.string.auxiliary_text_label')
                  }
                },
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_104)
          }
        }
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: {
                    symbol: $r('sys.symbol.star_circle_fill')
                  },
                }),
                textItem: {
                  primaryText: {
                    text: $r('app.string.icon_and_single_line_text_label')
                  },
                },
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_56)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: {
                    symbol: $r('sys.symbol.star_circle_fill')
                  },
                }),
                textItem: {
                  primaryText: {
                    text: $r('app.string.two_icons_on_the_right_label')
                  },
                },
                suffixItem: new SuffixSubIcon({
                  iconValue: {
                    symbol: $r('sys.symbol.circle_dashed')
                  },
                  onClick: () => {
                    hilog.info(0x00, 'EfficientList', 'The circle dash has been clicked currently.');
                  },
                }, {
                  iconValue: {
                    symbol: $r('sys.symbol.circle_dashed')
                  },
                  onClick: () => {
                    hilog.info(0x00, 'EfficientList', 'The circle dash has been clicked currently.');
                  },
                }),
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_56)
          }
        }
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .divider({
          strokeWidth: SIZE_NUM_1,
          startMargin: PADDING_40VP,
          endMargin: PADDING_6VP,
          color: $r('sys.color.comp_background_tertiary'),
        })

        ListItemGroup() {
          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: {
                    symbol: $r('sys.symbol.star_circle_fill')
                  },
                }),
                textItem: {
                  primaryText: {
                    text: $r('app.string.icon_and_double_line_text_label')
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  },
                },
                suffixItem: new SuffixText({
                  text: $r('app.string.right_text_label')
                }),
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_64)
          }

          ListItem() {
            Row() {
              HdsListItemCard({
                prefixItem: new PrefixIcon({
                  iconSize: IconSize.SYSTEM_ICON,
                  iconValue: {
                    symbol: $r('sys.symbol.star_circle_fill')
                  },
                }),
                textItem: {
                  primaryText: {
                    text: $r('app.string.icon_and_double_line_text_label')
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  },
                },
                suffixItem: new SuffixTextAndArrow({
                  text: $r('app.string.right_text_label')
                }, {}),
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
              })
            }
            .width(SIZE_PERCENT_100)
            .height(SIZE_NUM_64)
          }
        }
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
        .divider({
          strokeWidth: SIZE_NUM_1,
          startMargin: PADDING_40VP,
          endMargin: PADDING_6VP,
          color: $r('sys.color.comp_background_tertiary'),
        })
      }
      .height(SIZE_NUM_636)
      .width(SIZE_PERCENT_100)
    }
  }
}