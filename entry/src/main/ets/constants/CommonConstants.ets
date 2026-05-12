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

/**
 * Defines the list item data structure interface
 */
export interface ComponentItem {
  id: string;
  name: ResourceStr;
  url: ResourceStr;
}

/**
 * Defines the list group data structure interface
 */
export interface ComponentGroup {
  id: string;
  title: ResourceStr;
  items: ComponentItem[];
}

export interface ImageInfo {
  imgSrc: Resource;
  imgDescription: ResourceStr;
  littleIcon?: Resource;
}

export interface KeyItem {
  main: ResourceStr;
  sub: Resource;
}

export interface CallRecords {
  title: ResourceStr;
  subTitle: ResourceStr;
  callTime: ResourceStr;
}

/**
 * Master data source for home view component list
 */
export const COMPONENT_DATA: ComponentGroup[] = [
  {
    id: 'group_operation',
    title: $r('app.string.operation_components_label'),
    items: [
      { id: 'btn', name: $r('app.string.index_list_item_button_label'), url: 'ButtonExample' },
      { id: 'menu', name: $r('app.string.index_list_item_menu_label'), url: 'MenuExample' },
      { id: 'actionbar', name: $r('app.string.index_list_item_actionbar_label'), url: 'ActionBarExample' }
    ]
  },
  {
    id: 'group_selection',
    title: $r('app.string.selection_components_label'),
    items: [
      { id: 'toggle', name: $r('app.string.index_list_item_toggle_label'), url: 'ToggleExample' },
      { id: 'slider', name: $r('app.string.index_list_item_slider_label'), url: 'SliderExample' },
      { id: 'radio', name: $r('app.string.index_list_item_radio_label'), url: 'RadioExample' },
      { id: 'rating', name: $r('app.string.index_list_item_rating_label'), url: 'RatingExample' }
    ]
  },
  {
    id: 'group_display',
    title: $r('app.string.display_components_label'),
    items: [
      { id: 'progress', name: $r('app.string.index_list_item_progress_label'), url: 'ProgressExample' },
      { id: 'snakeBar', name: $r('app.string.index_list_item_snackbar_label'), url: 'HdsSnackBarExample' },
      { id: 'badge', name: $r('app.string.index_list_item_badge_label'), url: 'BadgeExample' },
      { id: 'toast', name: $r('app.string.index_list_item_toast_label'), url: 'ToastExample' }
    ]
  },
  {
    id: 'group_input',
    title: $r('app.string.input_components_label'),
    items: [
      { id: 'text_box', name: $r('app.string.index_list_item_textbox_label'), url: 'TextBoxExample' },
      { id: 'search_box', name: $r('app.string.index_list_item_searchbox_label'), url: 'SearchBoxExample' },
      { id: 'counter', name: $r('app.string.index_list_item_counter_label'), url: 'CounterExample' }
    ]
  },
  {
    id: 'group_navigation',
    title: $r('app.string.navigation_components_label'),
    items: [
      { id: 'bottom_tab_bar', name: $r('app.string.index_list_item_bottom_tab_bar_label'), url: 'BottomTabBarExample' },
      { id: 'title_bar', name: $r('app.string.index_list_item_title_bar_label'), url: 'TitleBarExample' },
      { id: 'sub_tabs', name: $r('app.string.index_list_item_sub_tabs_label'), url: 'SubTabBarExample' }
    ]
  },
  {
    id: 'group_container',
    title: $r('app.string.container_components_label'),
    items: [
      { id: 'list', name: $r('app.string.index_list_item_list_label'), url: 'ListExample' },
      { id: 'dialog', name: $r('app.string.index_list_item_dialog_label'), url: 'DialogExample' },
      { id: 'bind_sheet', name: $r('app.string.index_list_item_bind_sheet_label'), url: 'BindSheetExample' }
    ]
  }
];

export const LOADING_PROGRESS_EXAMPLE_NAME: string = 'LoadingProgressExample';

export const LANDSCAPE_SNACK_BAR_NAME: string = 'LandscapeSnackBarExample';

export const LANDSCAPE_BIND_SHEET_NAME: string = 'LandscapeBindSheetExample';

export const FULL_WIDTH_DETAIL_TEXT_BOX_NAME: string = 'FullWidthDetailTextBox';

export const EMPTY_PAGE_NAME: string = 'EmptyPage';

export const PHONE_DIALER_PAGE_NAME: string = 'PhoneDialerPage';

/**
 * Master data source for toast view component list
 */
export const TOAST_DATA: ComponentGroup[] = [
  {
    id: 'group_different_position_toast',
    title: $r('app.string.popup_position_label'),
    items: [
      { id: 'bottom_hint', name: $r('app.string.bottom_hint_label'), url: 'BottomToast' },
      {
        id: 'designated_location_hint',
        name: $r('app.string.designated_location_hint_label'),
        url: 'DesignatedPositionToast'
      }
    ]
  },
  {
    id: 'group_toast_display_in_portrait_mode',
    title: $r('app.string.responsive_design_label'),
    items: [
      {
        id: 'default_width_in_portrait_mode',
        name: $r('app.string.default_width_in_portrait_mode_label'),
        url: 'PortraitDefaultWidthToast'
      },
      {
        id: 'max_width_in_portrait_mode',
        name: $r('app.string.max_width_in_portrait_mode_label'),
        url: 'PortraitMaxWidthToast'
      }
    ]
  },
  {
    id: 'group_toast_display_in_landscape_mode',
    title: $r('app.string.landscape_specifications_label'),
    items: [
      {
        id: 'default_width_in_landscape_mode',
        name: $r('app.string.default_width_in_landscape_mode_label'),
        url: 'LandscapeDefaultWidthToast'
      },
      {
        id: 'max_width_in_landscape_mode',
        name: $r('app.string.max_width_in_landscape_mode_label'),
        url: 'LandscapeMaxWidthToast'
      }
    ]
  }
];

/**
 * Master data source for bottom tab bar view component list
 */
export const BOTTOM_TAB_BAR_DATA: ComponentGroup[] = [
  {
    id: 'group_different_tab_style',
    title: $r('app.string.subtitle_tab_style_label'),
    items: [
      { id: 'default_tab_style', name: $r('app.string.default_tab_style_label'), url: 'DefaultStyleTabBar' },
      { id: 'custom_tab_style', name: $r('app.string.custom_tab_style_label'), url: 'RudderStyleTabBar' }
    ]
  },
  {
    id: 'group_blur_style',
    title: $r('app.string.subtitle_blur_style_label'),
    items: [
      { id: 'backdrop_blur', name: $r('app.string.backdrop_blur_label'), url: 'BackdropBlurStyleTabBar' },
      { id: 'gradient_blur', name: $r('app.string.gradient_blur_label'), url: 'GradientBlurTabBar' }
    ]
  },
  {
    id: 'group_layout_principles',
    title: $r('app.string.subtitle_layout_principles_label'),
    items: [
      { id: 'left_right_layout', name: $r('app.string.left_right_layout_label'), url: 'LeftRightLayoutTabBar' },
      { id: 'split_view_sync_nav', name: $r('app.string.split_view_sync_nav_label'), url: 'SplitViewLayoutTabBar' }
    ]
  }
];

/**
 * Tab index2.
 */
export const TAB_INDEX_TWO: number = 2;

/**
 * Image data array.
 */
export const IMAGE_ARRAY: Resource[] = [
  $r('app.media.img_1'),
  $r('app.media.img_2'),
  $r('app.media.img_3'),
  $r('app.media.img_4'),
  $r('app.media.img_5'),
  $r('app.media.img_6'),
  $r('app.media.img_7'),
  $r('app.media.img_8'),
  $r('app.media.img_9'),
  $r('app.media.img_10'),
  $r('app.media.img_11'),
  $r('app.media.img_12'),
  $r('app.media.img_13'),
  $r('app.media.img_14'),
  $r('app.media.img_15'),
  $r('app.media.img_16'),
  $r('app.media.img_17'),
  $r('app.media.img_18'),
  $r('app.media.img_19'),
  $r('app.media.img_20')
];

export const IMAGE_DETAIL_DATA: ImageInfo[] = [
  {
    imgSrc: $r('app.media.img_1'),
    imgDescription: $r('app.string.music_description_1_label'),
  },
  {
    imgSrc: $r('app.media.img_2'),
    imgDescription: $r('app.string.music_description_2_label'),
    littleIcon: $r('sys.symbol.video_fill')
  },
  {
    imgSrc: $r('app.media.img_3'),
    imgDescription: $r('app.string.music_description_3_label'),
    littleIcon: $r('sys.symbol.heart_fill')
  },
  {
    imgSrc: $r('app.media.img_4'),
    imgDescription: $r('app.string.music_description_4_label')
  },
  {
    imgSrc: $r('app.media.img_5'),
    imgDescription: $r('app.string.music_description_5_label')
  },
  {
    imgSrc: $r('app.media.img_6'),
    imgDescription: $r('app.string.music_description_6_label'),
    littleIcon: $r('sys.symbol.heart_fill')
  },
  {
    imgSrc: $r('app.media.img_7'),
    imgDescription: $r('app.string.music_description_7_label')
  },
  {
    imgSrc: $r('app.media.img_8'),
    imgDescription: $r('app.string.music_description_8_label'),
    littleIcon: $r('sys.symbol.video_fill')
  },
  {
    imgSrc: $r('app.media.img_9'),
    imgDescription: $r('app.string.music_description_9_label'),
    littleIcon: $r('sys.symbol.heart_fill')
  },
  {
    imgSrc: $r('app.media.img_10'),
    imgDescription: $r('app.string.music_description_10_label')
  },
  {
    imgSrc: $r('app.media.img_11'),
    imgDescription: $r('app.string.music_description_1_label')
  },
  {
    imgSrc: $r('app.media.img_12'),
    imgDescription: $r('app.string.music_description_2_label'),
    littleIcon: $r('sys.symbol.heart_fill')
  }
];

/**
 * Image grid margin.
 */
export const VIDEO_GRID_MARGIN: number[] = [32, 48, 64];

/**
 * Lg sidebar width.
 */
export const LG_SIDEBAR_WIDTH: number = 96;

/**
 * Image grid item space.
 */
export const VIDEO_GRID_ITEM_SPACE: number = 12;

/**
 * Video dialog aspect ratio.
 */
export const VIDEO_DIALOG_ASPECT_RATIO: number = 1.74;

/**
 * Video grid description height.
 */
export const VIDEO_GRID_DESCRIPTION_HEIGHT: number = 120;

/**
 * Height unit.
 */
export const HEIGHT_UNIT: string = 'vp';

/**
 * Device types.
 */
export const DEVICE_TYPE: string = '2in1';

/**
 * Margin of window floating.
 */
export const WINDOW_FLOATING_MARGIN: number = 5.2;

/**
 * Video grid column list.
 */
export const VIDEO_GRID_COLUMNS: string[] = ['1fr', '1fr 1fr', '1fr 1fr 1fr', '1fr 1fr 1fr 1fr', '1fr 1fr 1fr 1fr 1fr',
  '1fr 1fr 1fr 1fr 1fr 1fr 1fr'];

/**
 * ClockInfo Interface Definition.
 */
export interface ClockInfo {
  timeZone: ResourceStr,
  alarmInfo: ResourceStr,
  scheduledAlarmTime: ResourceStr
}

/**
 * Multi-Timezone Alarm Dataset.
 */
export const CLOCK_DATA: ClockInfo[] = [
  { timeZone: 'Beijing', alarmInfo: 'Today', scheduledAlarmTime: '10:09' },
  { timeZone: 'Paris', alarmInfo: 'Today, 6 hours late', scheduledAlarmTime: '04:09' },
  { timeZone: 'London', alarmInfo: 'Today, 7 hours late', scheduledAlarmTime: '03:09' },
  { timeZone: 'New York', alarmInfo: 'Yesterday, 12 hours late', scheduledAlarmTime: '22:09' },
  { timeZone: 'Los Angeles', alarmInfo: 'Yesterday, 15 hours late', scheduledAlarmTime: '19:09' },
  { timeZone: 'Dubai', alarmInfo: 'Today, 4 hours late', scheduledAlarmTime: '06:09' },
  { timeZone: 'Bangkok', alarmInfo: 'Today, 1 hour late', scheduledAlarmTime: '09:09' },
  { timeZone: 'Tokyo', alarmInfo: 'Today, 1 hour early', scheduledAlarmTime: '11:09' },
  { timeZone: 'Sydney', alarmInfo: 'Today, 2 hours early', scheduledAlarmTime: '12:09' }
];

/**
 * Define the debounce interval time (unit: milliseconds). For example, multiple pop-ups are not allowed within 2000ms.
 */
export const DEFAULT_CLICK_INTERVAL: number = 2000;

export const LAYOUT_WEIGHT_1: number = 1;

// duration time
export const DURATION_NEGATIVE_1: number = -1;

export const DURATION_0: number = 0;

export const DURATION_100: number = 100;

export const DURATION_200: number = 200;

export const DURATION_300: number = 300;

export const DURATION_350: number = 350;

export const DURATION_400: number = 400;

export const DURATION_500: number = 500;

export const DURATION_2500: number = 2500;

export const DURATION_3000: number = 3000;

// Non-negative integer
export const INTEGER_0: number = 0;

export const INTEGER_1: number = 1;

export const INTEGER_2: number = 2;

export const INTEGER_3: number = 3;

export const INTEGER_5: number = 5;

export const INTEGER_10: number = 10;

export const INTEGER_36: number = 36;

export const INTEGER_50: number = 50;

export const INTEGER_99: number = 99;

export const INTEGER_100: number = 100;

export const INTEGER_180: number = 180;

export const INTEGER_1000: number = 1000;

// Float value
export const FLOAT_0_POINT_5: number = 0.5;

export const FLOAT_0_POINT_8: number = 0.8;

export const FLOAT_1: number = 1.0;

// Counter-related value
export const COUNTER_MAX_VALUE: number = 1000;

export const COUNTER_MIN_VALUE: number = 0;

export const COUNTER_STEP_VALUE_1: number = 1;

export const COUNTER_STEP_VALUE_2: number = 2;

export const COUNTER_INITIAL_VALUE: number = 999;

export const COUNTER_DATA_YEAR: number = 2016;

export const COUNTER_DATA_MONTH: number = 1;

export const COUNTER_DATA_DAY: number = 1;

// Threshold related to the text field
export const TEXT_MAX_LINES_1: number = 1;

export const TEXT_MAX_LINES_2: number = 2;

export const TEXT_MAX_LENGTH_10: number = 10;

export const TEXT_MAX_LENGTH_13: number = 13;

export const TEXT_MAX_LENGTH_20: number = 20;

export const TEXT_MAX_LENGTH_100: number = 100;

export const TEXT_THRESHOLD_PERCENTAGE: number = 1;

// Index of the default selected tab
export const DEFAULT_SELECTED_TAB_INDEX_1: number = 1;

export const DEFAULT_SELECTED_TAB_INDEX_2: number = 2;

// Offset value
export const Y_AXIS_NEGATIVE_OFFSET_8: number = -8;

export const Y_AXIS_OFFSET_40: number = 40;

// The number of columns in the current grid layout
export const COLUMNS_TEMPLATE_1: string = '1fr';

export const COLUMNS_TEMPLATE_2: string = '1fr 1fr';

export const COLUMNS_TEMPLATE_3: string = '1fr 1fr 1fr';

export const COLUMNS_TEMPLATE_4: string = '1fr 1fr 1fr 1fr';

export const COLUMNS_TEMPLATE_5: string = '1fr 1fr 1fr 1fr 1fr';

// Dialer interface data source
export const DIALER_DATA: KeyItem[] = [
  { main: '1', sub: $r('sys.symbol.recordingtape') },
  { main: '2', sub: $r('app.string.abc_label') },
  { main: '3', sub: $r('app.string.def_label') },
  { main: '4', sub: $r('app.string.ghi_label') },
  { main: '5', sub: $r('app.string.jkl_label') },
  { main: '6', sub: $r('app.string.mno_label') },
  { main: '7', sub: $r('app.string.pqrs_label') },
  { main: '8', sub: $r('app.string.tuv_label') },
  { main: '9', sub: $r('app.string.wxyz_label') },
  { main: $r('sys.symbol.staroflife'), sub: $r('app.string.special_p_label') },
  { main: '0', sub: $r('sys.symbol.plus') },
  { main: $r('sys.symbol.hash'), sub: $r('app.string.special_w_label') }
];

export const CALL_RECORDS_DATA: CallRecords[] = [
  {
    title: '159****2838',
    subTitle: $r('app.string.wuhan_label'),
    callTime: $r('app.string.a_moment_ago_label')
  },
  {
    title: '急救中心',
    subTitle: '120',
    callTime: $r('app.string.one_minute_ago_label')
  },
  {
    title: '火警',
    subTitle: '119',
    callTime: $r('app.string.two_minute_ago_label')
  }
];