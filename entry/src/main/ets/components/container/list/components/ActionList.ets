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
import { HdsListItem, HdsListItemCard, PrefixImage, SuffixArrowIconText, SuffixButton } from '@kit.UIDesignKit';
import { ImageModifier, ListItemModifier, SymbolGlyphModifier } from '@kit.ArkUI';
import { CommonUtils } from '../../../../utils/CommonUtils';
import { SPACE_12 } from '../../../../designtoken/Space';
import {
  SIZE_NUM_40,
  SIZE_NUM_48,
  SIZE_NUM_72,
  SIZE_NUM_80,
  SIZE_NUM_86,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import {
  CORNER_RADIUS_12,
  CORNER_RADIUS_16,
  CORNER_RADIUS_20,
  CORNER_RADIUS_8
} from '../../../../designtoken/CornerRadius';
import { DURATION_350, INTEGER_0 } from '../../../../constants/CommonConstants';
import { PADDING_6VP } from '../../../../designtoken/Padding';

@ComponentV2
export struct ActionList {
  @Local dataArr: string[] = [];
  @Local EndOffset: number = 0;
  @Local ListHeight: number = 256;

  aboutToAppear() {
    this.dataArr.length = 0;
    for (let i = 0; i < 1; i++) {
      this.dataArr.push(i + '');
    }
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.content_type_horizontally_swipe_interactive_list_label'))
      List({ space: SPACE_12 }) {
        ListItem() {
          Row() {
            HdsListItemCard({
              prefixItem: new PrefixImage({
                image: $r('app.media.avatar3'),
                modifier: new ImageModifier().width(SIZE_NUM_40).height(SIZE_NUM_40).borderRadius(CORNER_RADIUS_20)
              }),
              textItem: {
                primaryText: {
                  text: $r('app.string.avatar_and_double_line_text_label')
                },
                secondaryText: {
                  text: $r('app.string.auxiliary_text_label')
                }
              },
              suffixItem: new SuffixArrowIconText({
                endArrow: {}
              }),
              cardPrefixMargin: INTEGER_0,
              cardSuffixMargin: INTEGER_0,
              cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            })
          }
          .width(SIZE_PERCENT_100)
          .height(SIZE_NUM_72)
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
                image: $r('app.media.weather'),
                modifier: new ImageModifier().width(SIZE_NUM_48).height(SIZE_NUM_48).borderRadius(CORNER_RADIUS_12)
              }),
              textItem: {
                primaryText: {
                  text: $r('app.string.icon_and_small_button_label')
                },
                secondaryText: {
                  text: $r('app.string.auxiliary_text_label')
                }
              },
              suffixItem: new SuffixButton({
                text: $r('app.string.small_button_label'),
                onClick: () => {
                  CommonUtils.showToast($r('app.string.small_sized_button_toast_label'));
                }
              }),
              cardPrefixMargin: INTEGER_0,
              cardSuffixMargin: INTEGER_0,
              cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            })
          }
          .width(SIZE_PERCENT_100)
          .height(SIZE_NUM_80)
          .borderRadius(CORNER_RADIUS_16)
          .padding({
            left: PADDING_6VP,
            right: PADDING_6VP
          })
          .backgroundColor($r('sys.color.comp_background_list_card'))
        }

        Repeat(this.dataArr)
          .each(() => {
            HdsListItem({
              hdsListItemCard: {
                prefixItem: new PrefixImage({
                  image: $r('app.media.scenery2'),
                  modifier: new ImageModifier().width(SIZE_NUM_86).height(SIZE_NUM_48).borderRadius(CORNER_RADIUS_8)
                }),
                textItem: {
                  primaryText: {
                    text: $r('app.string.sixteen_by_nine_illustration_label'),
                  },
                  secondaryText: {
                    text: $r('app.string.auxiliary_text_label')
                  }
                },
                cardPrefixMargin: INTEGER_0,
                cardSuffixMargin: INTEGER_0,
                cardBackgroundColor: $r('sys.color.ohos_id_color_background_transparent')
              },
              swipeActionOptions: {
                icons: [
                  {
                    icon: new SymbolGlyphModifier($r('sys.symbol.share')).fontColor([Color.White])
                      .fontSize($r('sys.float.Body_L')),
                    backgroundColor: $r('sys.color.confirm'),
                    onAction: () => {
                      CommonUtils.showToast($r('app.string.share_button_toast_label'));
                    }
                  }
                ],
                deleteIconOptions: {
                  backgroundColor: Color.Red,
                  iconColor: Color.White,
                  onAction: () => {
                    CommonUtils.showToast($r('app.string.delete_button_toast_label'));
                    this.dataArr.splice(this.dataArr.length - 1, 1)
                    this.ListHeight = this.ListHeight - 92
                  }
                },
                fullDeleteOptions: {
                  // Swipe distance exceeding the size of the swiped component automatically triggers deletion. Default is false.
                  isFullDelete: true,
                  onFullDeleteAction: () => {
                    this.getUIContext()?.animateTo({
                      duration: DURATION_350,
                    }, () => {
                      this.dataArr.splice(this.dataArr.length - 1, 1)
                      this.ListHeight = this.ListHeight - 92
                    });
                  }
                }
              },
              listItemModifier: new ListItemModifier().width(SIZE_PERCENT_100)
                .height(SIZE_NUM_80)
                .borderRadius(CORNER_RADIUS_16)
                .padding({
                  left: PADDING_6VP,
                  right: PADDING_6VP
                })
                .backgroundColor($r('sys.color.comp_background_list_card'))
            })
          })
      }
      .width(SIZE_PERCENT_100)
      .height(this.ListHeight)
    }
  }
}