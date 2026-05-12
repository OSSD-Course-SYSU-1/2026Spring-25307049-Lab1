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
import { CORNER_RADIUS_16, CORNER_RADIUS_32, CORNER_RADIUS_8 } from '../../../../designtoken/CornerRadius';
import { PADDING_12VP, PADDING_16VP, PADDING_24VP, PADDING_8VP } from '../../../../designtoken/Padding';
import {
  SIZE_NUM_16,
  SIZE_NUM_188,
  SIZE_NUM_24,
  SIZE_NUM_40,
  SIZE_NUM_56,
  SIZE_PERCENT_100
} from '../../../../designtoken/Size';
import { BreakpointModel } from '../../../../model/BreakpointModel';
import { LAYOUT_WEIGHT_1 } from '../../../../constants/CommonConstants';
import { hilog } from '@kit.PerformanceAnalysisKit';

@ComponentV2
export struct GraphicDialog {
  @Local breakpointModel: BreakpointModel = BreakpointModel.getInstance();
  // Initialize custom dialog controller
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: ImageCustomDialog({
      onConfirm: () => {
        hilog.info(0x00, 'GraphicDialog', 'Confirm button has been clicked.');
      },
      onCancel: () => {
        hilog.info(0x00, 'GraphicDialog', 'Cancel button has been clicked.');
      }
    }),
    alignment: DialogAlignment.Center,
    autoCancel: true,
    customStyle: false,
  });

  build() {
    Row() {
      Text($r('app.string.graphical_dialog_label'))
        .fontSize($r('sys.float.Subtitle_M'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))

      Blank()

      SymbolGlyph($r('sys.symbol.chevron_right'))
        .fontSize($r('sys.float.Title_M'))
        .fontColor([$r('sys.color.icon_fourth')])
    }
    .onClick(() => {
      if (this.dialogController) {
        this.dialogController.open();
      }
    })
    .borderRadius(CORNER_RADIUS_16)
    .width(SIZE_PERCENT_100)
    .height(SIZE_NUM_56)
    .padding({
      left: PADDING_12VP,
      right: PADDING_12VP
    })
    .stateStyles({
      normal: {
        .backgroundColor($r('sys.color.comp_background_list_card'))
      },
      pressed: {
        .backgroundColor($r('app.color.list_item_pressed_color'))
      }
    })
  }
}

/**
 * Custom dialog component
 */
@CustomDialog
struct ImageCustomDialog {
  // Controller, must be defined, passed from outside
  controller?: CustomDialogController
  // Callback for confirm click
  onConfirm: () => void = () => {
  }
  // Callback for cancel click
  onCancel: () => void = () => {
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.rectangle'))
          .width(SIZE_PERCENT_100)
          .height(SIZE_NUM_188)
          .fillColor($r('app.color.image_fill_color'))
          .borderRadius(CORNER_RADIUS_8)
          .clip(true)

        Text($r('app.string.image_area_label'))
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.brand'))
          .fontWeight(FontWeight.Medium)
      }

      Row() {
        Text($r('app.string.graphical_dialog_label'))
          .fontSize($r('sys.float.Title_S'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_56)
      .margin({ top: PADDING_8VP })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Text('A'.repeat(45))
        .fontSize($r('sys.float.Body_L'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: PADDING_8VP })

      Row() {
        Button($r('app.string.cancel_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onCancel();
          })

        Divider()
          .vertical(true)
          .width(SIZE_NUM_16)
          .height(SIZE_NUM_24)
          .color($r('sys.color.comp_divider'))

        Button($r('app.string.confirm_label'))
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_emphasize'))
          .fontWeight(FontWeight.Medium)
          .layoutWeight(LAYOUT_WEIGHT_1)
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.onConfirm();
          })
      }
      .width(SIZE_PERCENT_100)
      .height(SIZE_NUM_40)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .borderRadius(CORNER_RADIUS_32)
    .padding({
      left: PADDING_24VP,
      right: PADDING_24VP,
      top: PADDING_24VP,
      bottom: PADDING_16VP
    })
  }
}