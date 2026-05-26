/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { CommonConstants, ResourceUtil } from '@ohos/commons';
import { HomeConstants } from '../constants/HomeConstants';

@Builder
export function HomeButton(buttonText: string = '') {
  Button(buttonText)
    .backgroundColor($r('app.color.button_color'))
    .borderRadius(ResourceUtil.getCommonBorderRadius()[5])
    .height($r('app.float.button_height'))
    .width($r('app.float.button_width'))
    .fontColor(Color.White)
    .fontSize($r('app.float.button_font'))
    .fontWeight(CommonConstants.FONT_WEIGHT_500)
}

@Builder
export function TitleView(titleText: string = '', context: Context = this.getUIContext().getHostContext()!) {
  Row() {
    Text(titleText)
      .fontSize($r('app.float.title_font'))
      .lineHeight($r('app.float.title_line'))
      .fontWeight(CommonConstants.FONT_WEIGHT_500)

    Blank()

    Text(HomeConstants.TIP_TEXTS(context)[1])
      .fontSize($r('app.float.title_tip_font'))
      .lineHeight($r('app.float.title_tip_line'))
      .fontWeight(FontWeight.Normal)
      .opacity(CommonConstants.TEXT_OPACITY[2])
    Image(ResourceUtil.getArrowRight())
      .width(ResourceUtil.getCommonImgSize()[0])
      .height(ResourceUtil.getCommonImgSize()[0])
  }
  .width(CommonConstants.FULL_PERCENT)
  .height($r('app.float.title_height'))
  .padding({
    left: $r('app.float.title_view_padding'),
    right: $r('app.float.title_view_padding')
  })
}

@Builder
export function ProductTitle(title: string[] = [], isCenter: boolean = true) {
  Row() {
    if (title.length !== 1) {
      Text(title[1])
        .lineHeight($r('app.float.section_tip_text_line'))
        .fontSize($r('app.float.section_tip_text_size'))
        .fontColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .linearGradient({
          direction: GradientDirection.Right,
          repeating: false,
          colors: [[HomeConstants.GRADIENT_COLORS[2], 0.0], [HomeConstants.GRADIENT_COLORS[3], 1.0]]
        })
        .backgroundColor($r('app.color.section_tip_background'))
        .borderRadius(ResourceUtil.getCommonBorderRadius()[1])
        .textAlign(TextAlign.Center)
        .padding({
          left: $r('app.float.section_tip_text_padding'),
          right: $r('app.float.section_tip_text_padding')
        })
        .margin({ right: $r('app.float.section_tip_text_margin') })
    }
    Text(title[0])
      .fontSize($r('app.float.section_title_text_size'))
      .lineHeight($r('app.float.section_title_text_line'))
      .fontWeight(CommonConstants.FONT_WEIGHT_500)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .layoutWeight(isCenter ? 0 : 1)
  }
  .justifyContent(isCenter ? FlexAlign.Center : FlexAlign.Start)
}

@Builder
export function ProductInfo(info: string = '') {
  if (info === '') {
    Blank()
      .height($r('app.float.section_info_text_line'))
  } else {
    Text(info)
      .fontSize($r('app.float.section_info_text_size'))
      .lineHeight($r('app.float.section_info_text_line'))
      .fontWeight(FontWeight.Normal)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .opacity(CommonConstants.TEXT_OPACITY[1])
      .margin({ top: $r('app.float.section_info_text_margin') })
  }
}

@Builder
export function ProductPrice(price: string = '', originalPrice: string = '') {
  Row() {
    Text(price)
      .fontSize($r('app.float.section_price_text_size'))
      .lineHeight($r('app.float.section_price_text_line'))
      .fontColor($r('app.color.section_text'))
      .fontWeight(CommonConstants.FONT_WEIGHT_500)
    if (originalPrice !== '') {
      Text(originalPrice)
        .fontSize($r('app.float.original_price_text_size'))
        .lineHeight($r('app.float.original_price_text_line'))
        .fontWeight(FontWeight.Normal)
        .fontColor($r('app.color.original_price_color'))
        .decoration({
          type: TextDecorationType.LineThrough,
          color: $r('app.color.original_price_color')
        })
        .margin({ left: $r('app.float.original_price_text_margin')})
    }
  }
  .margin({ top: $r('app.float.section_price_text_margin') })
}

@Builder
export function ProductFeature(feature: string[] = []) {
  Row() {
    ForEach(feature, (itemStr: string) => {
      Text(itemStr)
        .fontSize($r('app.float.section_feature_text_size'))
        .lineHeight($r('app.float.section_feature_text_line'))
        .fontColor($r('app.color.section_text'))
        .fontWeight(FontWeight.Normal)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({
          left: $r('app.float.section_feature_padding'),
          right: $r('app.float.section_feature_padding')
        })
        .margin({
          top: $r('app.float.section_feature_margin_top'),
          left: $r('app.float.section_feature_margin_left')
        })
        .border({
          width: $r('app.float.section_feature_border_width'),
          color: $r('app.color.section_feature_border_color'),
          radius: $r('app.float.section_feature_border_radius'),
          style: BorderStyle.Solid
        })
    }, (item: string, index: number) => index + JSON.stringify(item))
  }
}

@Builder
export function ProductComments(comments: string = '') {
  Text(comments)
    .fontSize($r('app.float.section_comments_text_size'))
    .fontWeight(FontWeight.Normal)
    .lineHeight($r('app.float.section_comments_text_line'))
    .maxLines(1)
    .textOverflow({ overflow: TextOverflow.Ellipsis })
    .opacity(CommonConstants.TEXT_OPACITY[1])
    .margin({
      top: $r('app.float.section_comments_text_top'),
      bottom: $r('app.float.section_comments_text_bottom')
    })
}