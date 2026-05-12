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
import { HdsListItemCard, PrefixImage } from '@kit.UIDesignKit';
import { ImageModifier } from '@kit.ArkUI';
import { SPACE_12 } from '../../../../designtoken/Space';
import {
  SIZE_NUM_104,
  SIZE_NUM_128,
  SIZE_NUM_444,
  SIZE_NUM_48,
  SIZE_NUM_56,
  SIZE_NUM_64,
  SIZE_NUM_66,
  SIZE_NUM_72,
  SIZE_NUM_88,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { CORNER_RADIUS_16, CORNER_RADIUS_8 } from '../../../../designtoken/CornerRadius';
import { INTEGER_0 } from '../../../../constants/CommonConstants';
import { PADDING_6VP } from '../../../../designtoken/Padding';

@Builder
export function ContentList() {
  Column() {
    subTitleBuilder($r('app.string.content_type_list_label'))
    List({ space: SPACE_12 }) {
      ListItem() {
        Row() {
          HdsListItemCard({
            prefixItem: new PrefixImage({
              image: $r('app.media.scenery3'),
              modifier: new ImageModifier().width(SIZE_NUM_56).height(SIZE_NUM_56).borderRadius(CORNER_RADIUS_8)
            }),
            textItem: {
              primaryText: {
                text: $r('app.string.small_image_and_three_line_list_label')
              },
              secondaryText: {
                text: $r('app.string.auxiliary_text_label')
              },
              description: {
                text: $r('app.string.auxiliary_text_label')
              },
            },
            cardPrefixMargin: INTEGER_0,
            cardSuffixMargin: INTEGER_0,
            cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
          })
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_88)
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
      }

      ListItem() {
        Row() {
          HdsListItemCard({
            prefixItem: new PrefixImage({
              image: $r('app.media.scenery4'),
              modifier: new ImageModifier().width(SIZE_NUM_48).height(SIZE_NUM_64).borderRadius(CORNER_RADIUS_8)
            }),
            textItem: {
              primaryText: {
                text: $r('app.string.three_by_four_small_image_label')
              },
              secondaryText: {
                text: $r('app.string.auxiliary_text_label')
              },
              description: {
                text: $r('app.string.auxiliary_text_label')
              },
            },
            cardPrefixMargin: INTEGER_0,
            cardSuffixMargin: INTEGER_0,
            cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
          })
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_88)
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
      }

      ListItem() {
        Row() {
          HdsListItemCard({
            prefixItem: new PrefixImage({
              image: $r('app.media.scenery5'),
              modifier: new ImageModifier().width(SIZE_NUM_72).height(SIZE_NUM_72).borderRadius(CORNER_RADIUS_8)
            }),
            textItem: {
              primaryText: {
                text: $r('app.string.image_and_three_line_list_label')
              },
              secondaryText: {
                text: $r('app.string.auxiliary_text_label')
              },
              description: {
                text: $r('app.string.auxiliary_text_label')
              },
            },
            cardPrefixMargin: INTEGER_0,
            cardSuffixMargin: INTEGER_0,
            cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
          })
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_104)
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
      }

      ListItem() {
        Row() {
          HdsListItemCard({
            prefixItem: new PrefixImage({
              image: $r('app.media.scenery6'),
              modifier: new ImageModifier().width(SIZE_NUM_66).height(SIZE_NUM_88).borderRadius(CORNER_RADIUS_8)
            }),
            textItem: {
              primaryText: {
                text: $r('app.string.three_by_four_image_label')
              },
              secondaryText: {
                text: $r('app.string.auxiliary_text_label')
              },
              description: {
                text: $r('app.string.auxiliary_text_label')
              },
            },
            cardPrefixMargin: INTEGER_0,
            cardSuffixMargin: INTEGER_0,
            cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
          })
        }
        .width(SIZE_PERCENT_100)
        .height(SIZE_NUM_128)
        .borderRadius(CORNER_RADIUS_16)
        .padding({
          left: PADDING_6VP,
          right: PADDING_6VP
        })
        .backgroundColor($r('sys.color.comp_background_list_card'))
      }
    }
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_444)
  }
}