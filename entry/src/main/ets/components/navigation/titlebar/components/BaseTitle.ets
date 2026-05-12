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
import { HdsNavDestination, ScrollEffectType } from '@kit.UIDesignKit';
import { LengthMetrics } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PADDING_0VP, PADDING_16VP, PADDING_20VP, PADDING_28VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56 } from '../../../../designtoken/Size';

@Builder
export function BaseTitle() {
  Column() {
    subTitleBuilder($r('app.string.ordinary_title_bar_label'), PADDING_28VP)
    HdsNavDestination()
      .height(SIZE_NUM_56)
      .titleBar({
        padding: {
          start: LengthMetrics.vp(PADDING_16VP),
          end: LengthMetrics.vp(PADDING_16VP)
        },
        style: {
          scrollEffectOpts: {
            enableScrollEffect: true,
            scrollEffectType: ScrollEffectType.COMMON_BLUR,
            blurEffectiveStartOffset: LengthMetrics.vp(PADDING_0VP),
            blurEffectiveEndOffset: LengthMetrics.vp(PADDING_20VP)
          },
          originalStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.comp_background_list_card')
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
            }
          },
          scrollEffectStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.ohos_id_color_background_transparent')
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
              menuStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              },
              backIconStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              }
            }
          }
        },
        content: {
          title: {
            mainTitle: 'Title'
          },
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'BaseTitle', "HdsNavDestination menu1");
                }
              }
            }, {
              content: {
                label: 'menu2',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'BaseTitle', "HdsNavDestination menu2");
                }
              }
            }, {
              content: {
                label: 'menu3',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'BaseTitle', "HdsNavDestination menu3");
                }
              }
            }]
          }
        }
      })
      .hideBackButton(true)

    subTitleBuilder($r('app.string.plain_double_row_title_bar_label'), PADDING_28VP)
    HdsNavDestination()
      .height(SIZE_NUM_56)
      .titleBar({
        padding: {
          start: LengthMetrics.vp(PADDING_16VP),
          end: LengthMetrics.vp(PADDING_16VP)
        },
        style: {
          scrollEffectOpts: {
            enableScrollEffect: true,
            scrollEffectType: ScrollEffectType.COMMON_BLUR,
            blurEffectiveStartOffset: LengthMetrics.vp(PADDING_0VP),
            blurEffectiveEndOffset: LengthMetrics.vp(PADDING_20VP)
          },
          originalStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.comp_background_list_card'),
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
            }
          },
          scrollEffectStyle: {
            backgroundStyle: {
              backgroundColor: $r('sys.color.ohos_id_color_background_transparent'),
            },
            contentStyle: {
              titleStyle: {
                mainTitleColor: $r('sys.color.font_primary'),
                subTitleColor: $r('sys.color.font_secondary')
              },
              menuStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              },
              backIconStyle: {
                backgroundColor: $r('sys.color.comp_background_tertiary'),
                iconColor: $r('sys.color.icon_primary')
              }
            }
          }
        },
        content: {
          title: {
            mainTitle: 'Title',
            subTitle: 'SubTitle'
          },
          menu: {
            value: [{
              content: {
                label: 'menu1',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'BaseTitle', "HdsNavDestination menu1");
                }
              }
            }, {
              content: {
                label: 'menu2',
                icon: $r('sys.symbol.circle_dashed'),
                isEnabled: true,
                action: () => {
                  hilog.info(0x00, 'BaseTitle', "HdsNavDestination menu2");
                }
              }
            }]
          }
        }
      })
      .hideBackButton(true)
  }
}