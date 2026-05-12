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
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarOperationType,
  SnackBarStyleOptions
} from '@kit.UIDesignKit';
import { ColorMetrics } from '@kit.ArkUI';
import { DURATION_2500, DURATION_NEGATIVE_1, LANDSCAPE_SNACK_BAR_NAME } from '../../../../constants/CommonConstants';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { CORNER_RADIUS_16 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP } from '../../../../designtoken/Padding';
import { SIZE_NUM_56, SIZE_PERCENT_100 } from '../../../../designtoken/Size';
import { SPACE_4 } from '../../../../designtoken/Space';

@ComponentV2
export struct CommonSnackBar {
  @Consumer('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private uiContext: UIContext | null = null;
  private hdsSnackBar: HdsSnackBar | null = null;
  private curTitleColor: ColorMetrics | undefined = undefined;
  private message1: SnackBarMessageOptions = {
    title: $r('app.string.scheduled_shutdown_label'),
    titleColor: this.curTitleColor
  };
  private message2: SnackBarMessageOptions = {
    title: $r('app.string.residency_label'),
    titleColor: this.curTitleColor
  };
  private curArrowColor: ColorMetrics[] | undefined = undefined;
  private operation1: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_ARROW,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton1',
    arrowColor: this.curArrowColor,
    onArrowClick: () => {
      hilog.info(0x00, 'CommonSnackBar', 'Arrow clicked.');
    }
  };
  private icon: SnackBarIconOptions = {
    icon: $r('sys.symbol.star_circle_fill')
  };
  private style1: SnackBarStyleOptions = {
    duration: DURATION_2500
  };
  private operation2: SnackBarOperationOptions = {
    operationType: SnackBarOperationType.TEXT_WITH_CLOSE,
    content: 'TEXT BT',
    textButtonId: 'snackBarTextButton2',
    onContentClick: () => {
      hilog.info(0x00, 'CommonSnackBar', `Content clicked.`);
    }
  };
  private style2: SnackBarStyleOptions = {
    duration: DURATION_NEGATIVE_1
  };

  aboutToAppear(): void {
    this.uiContext = this.getUIContext();
    this.hdsSnackBar = new HdsSnackBar(this.uiContext);
    try {
      this.curTitleColor = ColorMetrics.resourceColor($r('sys.color.font_primary'));
      this.curArrowColor = [ColorMetrics.resourceColor($r('sys.color.icon_emphasize'))];
    } catch (err) {
      hilog.error(0x00, 'CommonSnackBar', 'Failed to instantiate the ColorMetrics class using ResourceColor');
    }
  }

  aboutToDisappear(): void {
    this.hdsSnackBar?.dismiss();
    this.hdsSnackBar = null;
  }

  build() {
    Column() {
      subTitleBuilder($r('app.string.configuration_type_classification_label'))

      Row() {
        Text($r('app.string.scheduled_shutdown_mode_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor(['#C4C6CC'])
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CORNER_RADIUS_16)
      .padding(PADDING_12VP)
      .margin({ bottom: PADDING_12VP })
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })
      .onClick(() => {
        this.hdsSnackBar?.show(this.icon, this.message1, this.operation1, this.style1);
      })

      Row() {
        Text($r('app.string.resident_mode_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)

        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize($r('sys.float.Title_M'))
          .fontColor(['#C4C6CC'])
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CORNER_RADIUS_16)
      .padding(PADDING_12VP)
      .stateStyles({
        normal: {
          .backgroundColor($r('sys.color.comp_background_list_card'))
        },
        pressed: {
          .backgroundColor($r('app.color.list_item_pressed_color'))
        }
      })
      .onClick(() => {
        this.hdsSnackBar?.show(this.icon, this.message2, this.operation2, this.style2);
      })

      subTitleBuilder($r('app.string.phone_in_landscape_mode_maximum_width_label'))

      Row() {
        Text($r('app.string.landscape_mode_label'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Medium)

        Row({ space: SPACE_4 }) {
          Text($r('app.string.view_example_label'))
            .fontColor($r('sys.color.background_emphasize'))
            .fontSize($r('sys.float.Body_M'))
            .fontWeight(FontWeight.Regular)
          SymbolGlyph($r('sys.symbol.chevron_right'))
            .fontSize($r('sys.float.Title_M'))
            .fontColor([$r('sys.color.icon_fourth')])
        }
        .onClick(() => {
          this.navPathStack.pushPath({ name: LANDSCAPE_SNACK_BAR_NAME });
        })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CORNER_RADIUS_16)
      .backgroundColor($r('sys.color.comp_background_list_card'))
      .padding(PADDING_12VP)
    }
    .width(SIZE_PERCENT_100)
  }
}