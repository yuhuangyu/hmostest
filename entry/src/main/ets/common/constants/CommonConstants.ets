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
import NewsTypeModel from "../../viewmodel/NewsTypeModel";

/**
 * Common constants for all features.
 */
export class CommonConstants {

  static readonly TAG: string = "uuu";
  static readonly PREFERENCES_NAME: string = "uuu_Store";

  /**
   * The host address of the server.
   */
  static readonly SERVER: string = 'http://**.**.**.**:9588';

  /**
   * Get the news type.
   */
  static readonly GET_NEWS_TYPE: string = 'news/getNewsType';

  /**
   * Get the news list.
   */
  static readonly GET_NEWS_LIST: string = 'news/getNewsList';

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: string = 'success';

  /**
   * The off set coefficient.
   */
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 4;

  /**
   * The refresh and load height.
   */
  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The animation delay time.
   */
  static readonly DELAY_ANIMATION_DURATION: number = 300;

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

  static readonly DEFAULT_TOTAL_MINUTE: number = 10;

  /**
   * Full the width.
   */
  static readonly FULL_WIDTH: string = '100%';

  /**
   * Full the height.
   */
  static readonly FULL_HEIGHT: string = '100%';

  /**
   * The TabBars constants.
   */
  static readonly TabBars_UN_SELECT_TEXT_FONT_SIZE: number = 18;
  static readonly TabBars_SELECT_TEXT_FONT_SIZE: number = 24;
  static readonly TabBars_UN_SELECT_TEXT_FONT_WEIGHT: number = 400;
  static readonly TabBars_SELECT_TEXT_FONT_WEIGHT: number = 700;
  static readonly TabBars_BAR_HEIGHT: string = '7.2%';
  static readonly TabBars_HORIZONTAL_PADDING: string  = '2.2%';
  static readonly TabBars_BAR_WIDTH: string = '100%';
  static readonly TabBars_DEFAULT_NEWS_TYPES: Array<NewsTypeModel> = [
    { id: 0, name: '全部' },
    { id: 1, name: '按钮' },
    { id: 2, name: '动画' },
    { id: 3, name: '娱乐' },
    { id: 4, name: '军事' },
    { id: 5, name: '体育' },
    { id: 6, name: '科技' },
    { id: 7, name: '财经' }
  ];

  /**
   * The NewsListConstant constants.
   */
  static readonly NewsListConstant_LIST_DIVIDER_STROKE_WIDTH: number = 0.5;
  static readonly NewsListConstant_GET_TAB_DATA_TYPE_ONE: number = 1;
  static readonly NewsListConstant_ITEM_BORDER_RADIUS: number = 16;
  static readonly NewsListConstant_NONE_IMAGE_SIZE: number = 120;
  static readonly NewsListConstant_NONE_TEXT_opacity: number = 0.6;
  static readonly NewsListConstant_NONE_TEXT_size: number = 16;
  static readonly NewsListConstant_NONE_TEXT_margin: number = 12;
  static readonly NewsListConstant_ITEM_MARGIN_TOP: string = '1.5%';
  static readonly NewsListConstant_LIST_MARGIN_LEFT: string = '3.3%';
  static readonly NewsListConstant_LIST_MARGIN_RIGHT: string = '3.3%';
  static readonly NewsListConstant_ITEM_HEIGHT: string = '32%';
  static readonly NewsListConstant_LIST_WIDTH: string =  '93.3%';

  /**
   * The NewsTitle constants.
   */
  static readonly NewsTitle_TEXT_MAX_LINES: number = 3;
  static readonly NewsTitle_TEXT_FONT_SIZE: number = 20;
  static readonly NewsTitle_TEXT_FONT_WEIGHT: number = 500;
  static readonly NewsTitle_TEXT_MARGIN_LEFT: string = '2.4%';
  static readonly NewsTitle_TEXT_MARGIN_TOP: string = '7.2%';
  static readonly NewsTitle_TEXT_HEIGHT: string = '9.6%';
  static readonly NewsTitle_TEXT_WIDTH: string = '78.6%';
  static readonly NewsTitle_IMAGE_MARGIN_LEFT: string = '3.5%';
  static readonly NewsTitle_IMAGE_MARGIN_TOP: string = '7.9%';
  static readonly NewsTitle_IMAGE_HEIGHT: string = '8.9%';
  static readonly NewsTitle_IMAGE_WIDTH: string = '11.9%';

  /**
   * The NewsContent constants.
   */
  static readonly NewsContent_WIDTH: string = '93%';
  static readonly NewsContent_HEIGHT: string = '16.8%';
  static readonly NewsContent_MARGIN_LEFT: string = '3.5%';
  static readonly NewsContent_MARGIN_TOP: string = '3.4%';
  static readonly NewsContent_MAX_LINES: number = 2;
  static readonly NewsContent_FONT_SIZE: number = 15;

  /**
   * The NewsSource constants.
   */
  static readonly NewsSource_MAX_LINES: number = 1;
  static readonly NewsSource_FONT_SIZE: number = 12;
  static readonly NewsSource_MARGIN_LEFT: string = '3.5%';
  static readonly NewsSource_MARGIN_TOP: string = '3.4%';
  static readonly NewsSource_HEIGHT: string = '7.2%';
  static readonly NewsSource_WIDTH: string = '93%';

  /**
   * The NewsGrid constants.
   */
  static readonly NewsGrid_MARGIN_LEFT: string = '3.5%';
  static readonly NewsGrid_MARGIN_RIGHT: string = '3.5%';
  static readonly NewsGrid_MARGIN_TOP: string = '5.1%';
  static readonly NewsGrid_WIDTH: string = '93%';
  static readonly NewsGrid_HEIGHT: string = '31.5%';
  static readonly NewsGrid_ASPECT_RATIO: number = 4;
  static readonly NewsGrid_COLUMNS_GAP: number = 5;
  static readonly NewsGrid_ROWS_TEMPLATE: string = '1fr';
  static readonly NewsGrid_IMAGE_BORDER_RADIUS: number = 8;

  /**
   * The RefreshLayout constants.
   */
  static readonly RefreshLayout_MARGIN_LEFT: string = '40%';
  static readonly RefreshLayout_TEXT_MARGIN_BOTTOM: number = 1;
  static readonly RefreshLayout_TEXT_MARGIN_LEFT: number = 7;
  static readonly RefreshLayout_TEXT_FONT_SIZE: number = 17;
  static readonly RefreshLayout_IMAGE_WIDTH: number = 18;
  static readonly RefreshLayout_IMAGE_HEIGHT: number = 18;

  /**
   * The NoMoreLayout constants.
   */
  static readonly NoMoreLayoutConstant_NORMAL_PADDING: number = 8;
  static readonly NoMoreLayoutConstant_TITLE_FONT: string = '16fp';

  /**
   * The RefreshConstant constants.
   */
  static readonly RefreshConstant_DELAY_PULL_DOWN_REFRESH: number = 50;
  static readonly RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME: number = 150;
  static readonly RefreshConstant_DELAY_SHRINK_ANIMATION_TIME: number = 500;


  /**
   * String for input content.
   */
  static readonly OFFSET_X: number = 0;

  /**
   * String for input content.
   */
  static readonly OFFSET_Y: number = -25;

  /**
   * Number for zip level.
   */
  static readonly PERCENT_NINETY: string = '90%';

  /**
   * Number for zip level.
   */
  static readonly PERCENT_FULL: string = '100%';

  /**
   * Number for zip level.
   */
  static readonly FONT_WEIGHT_SEVEN_HUNDRED: number = 700;

  /**
   * Number for zip level.
   */
  static readonly LEAP_YEAR_INPUT: string = '请输入一个年份';

  /**
   * Number for zip level.
   */
  static readonly LEAP_YEAR_YES: string = '该年份是闰年';

  /**
   * Number for zip level.
   */
  static readonly LEAP_YEAR_NO: string = '该年份不是闰年';

  /**
   * Number for zip level.
   */
  static readonly STRING_INPUT: string = '请输入一个字符串';

  /**
   * Number for zip level.
   */
  static readonly PALINDROMIC_STRING_YES: string = '该字符串是回文字符串';

  /**
   * Number for zip level.
   */
  static readonly PALINDROMIC_STRING_NO: string = '该字符串不是回文字符串';

  /**
   * Number for zip level.
   */
  static readonly STRING_PRE: string = '反转结果为：';

  /**
   * The time of toast
   */
  static readonly TOAST_TIME: number = 2000;


  /**
   * Full width or height.
   */
  static readonly FULL_LENGTH: string = '100%';

  /**
   * Title height.
   */
  static readonly TITLE_WIDTH: string = '80%';

  /**
   * List default width.
   */
  static readonly LIST_DEFAULT_WIDTH: string = '93.3%';

  /**
   * Opacity of default.
   */
  static readonly OPACITY_DEFAULT: number = 1;

  /**
   * Opacity of default.
   */
  static readonly OPACITY_COMPLETED: number = 0.4;

  /**
   * BorderRadius of list item.
   */
  static readonly BORDER_RADIUS: number = 24;

  /**
   * BorderRadius of list item.
   */
  static readonly FONT_WEIGHT: number = 500;

  /**
   * Space of column.
   */
  static readonly COLUMN_SPACE: number = 16;

  /**
   * agents data.
   */
  static readonly TODO_DATA: Array<string> = [
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松"
  ];


  /**
   * Get the news list.
   */
  static readonly UPLOAD_NEWS: string = 'news/addNews';

  /**
   * Upload File
   */
  static readonly UPLOAD_FILE: string = '/files/upload';

  /**
   * UploadFile
   */
  static readonly IMAGE_PREFIX: string = '/images/';

  /**
   * url of NewsUploadPage
   */
  static readonly NEWS_EDIT_PAGE: string = 'pages/NewsEditPage'


  /**
   * Gt tab data current page.
   */
  static readonly GET_TAB_DATA_CURRENT_PAGE: number = 1;


  /**
   * Content maxLine.
   */
  static readonly CONTENT_MAX_LINE: number = 3;

  /**
   * List space.
   */
  static readonly LIST_SPACE: number = 12;

  /**
   * Item img space.
   */
  static readonly ITEM_IMG_SPACE: number = 8;

  /**
   * Type font weight.
   */
  static readonly TYPE_FONT_WEIGHT: number = 700;

  /**
   * Title font weight.
   */
  static readonly TITLE_FONT_WEIGHT: number = 500;

  /**
   * Desc font weight.
   */
  static readonly DESC_FONT_WEIGHT: number = 400;

  /**
   * Type aspect ratio.
   */
  static readonly TYPE_ASPECT_RATIO: number = 2;

  /**
   * Desc opacity.
   */
  static readonly DESC_OPACITY: number = 0.6;

  /**
   * 100 percent.
   */
  static readonly FULL_PERCENT: string = '100%';

  /**
   * Divider width.
   */
  static readonly DIVIDER_WIDTH: string = '90%';

  /**
   * Release title.
   */
  static readonly RELEASE_TITLE: string = '新闻发布';


  static readonly LAUNCHER_PAGE_TAG: string = 'LauncherPage';

  /**
   * The advertsing page tag.
   */
  static readonly ADVERTISING_PAGE_TAG: string = 'AdvertisingPage';

  /**
   * The custom dialog component tag.
   */
  static readonly CUSTOM_DIALOG_TAG: string = 'CustomDialogComponent';

  /**
   * Preference saved key.
   */
  static readonly PREFERENCES_KEY_PRIVACY: string = 'isPrivacy';

  /**
   * Preference saved file name.
   */
  static readonly PREFERENCES_FILE_NAME: string = 'myStore';

  /**
   * Launcher page count down.
   */
  static readonly LAUNCHER_DELAY_TIME: number = 3000;

  /**
   * Image logo top margin.
   */
  static readonly LAUNCHER_IMAGE_MARGIN_TOP: string = '16.2%';

  /**
   * Healthy living text spacing.
   */
  static readonly LAUNCHER_LIFE_TEXT_SPACING: number = 0.1;

  /**
   * Healthy living title text top margin.
   */
  static readonly LAUNCHER_TEXT_TITLE_MARGIN_TOP: string = '0.5%';

  /**
   * Content control height.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_HEIGHT: string = '2.7%';

  /**
   * Healthy living instructions.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_SPACING: number = 3.4;

  /**
   * Healthy living content top margin.
   */
  static readonly LAUNCHER_TEXT_INTRODUCE_MARGIN_TOP: string = '1.3%';

  /**
   * Interval execution time.
   */
  static readonly ADVERTISING_INTERVAL_TIME: number = 1000;

  /**
   * Advertising page url.
   */
  static readonly ADVERTISING_PAGE_URL: string = 'pages/AdvertisingPage';

  /**
   * Display countdown seconds.
   */
  static readonly ADVERTISING_COUNT_DOWN_SECONDS: number = 2;

  /**
   * Count down text spacing.
   */
  static readonly ADVERTISING_TITLE_TEXT_LETTER_SPACING: number = 0.05;

  /**
   * Advertising page healthy text spacing.
   */
  static readonly ADVERTISING_HEALTHY_LIFE_TEXT_SPACING: number = 0.1;

  /**
   * Advertising page health description text spacing.
   */
  static readonly ADVERTISING_TEXT_INTRODUCE_LETTER_SPACING: number = 3.4;

  /**
   * Advertising page health description text top margin.
   */
  static readonly ADVERTISING_TEXT_INTRODUCE_MARGIN_TOP: string = '0.4%';

  /**
   * Column container left margin.
   */
  static readonly ADVERTISING_COLUMN_MARGIN_LEFT: string = '3.1%';

  /**
   * Row container bottom margin.
   */
  static readonly ADVERTISING_ROW_MARGIN_BOTTOM: string = '3.1%';

  /**
   * Dialog component width the percentage of the 90.
   */
  static readonly DIALOG_COMPONENT_WIDTH_PERCENT: string = '90%';

  /**
   * Dialog title text weight.
   */
  static readonly DIALOG_TITLE_FONT_WEIGHT: number = 600;

  /**
   * Dialog width the percentage of the 93.3.
   */
  static readonly DIALOG_WIDTH_PERCENT: string = '93.3%';

  /**
   * Dialog border radius.
   */
  static readonly DIALOG_BORDER_RADIUS: number = 24;

  /**
   * Dialog component bottom margin,
   */
  static readonly DIALOG_ROW_MARGIN_BOTTOM: string = '3.1%';

  /**
   * Dialog y-axis offset distance.
   */
  static readonly DIALOG_CONTROLLER_DY_OFFSET: number = -24;

  /**
   * Privacy page url.
   */
  static readonly PRIVACY_PAGE_URL: string = 'pages/PrivacyPage';

  /**
   * App home page url.
   */
  static readonly APP_HOME_PAGE_URL: string = 'pages/AppHomePage';

  /**
   * Common layout weight.
   */
  static readonly COMMON_LAYOUT_WEIGHT: number = 1;


  /**
   * The name of download file.
   */
  static readonly DOWNLOAD_FILE: string = '1653067.mp4';

  /**
   * The size of download file.
   */
  static readonly FILE_SIZE: string = '25.01MB';
  /**
   * Font weight of Large.
   */
  static readonly FONT_WEIGHT_LAGER: number = 500;

  /**
   * Font opacity.
   */
  static readonly FONT_OPACITY: number = 0.6;

  /**
   * Progress total.
   */
  static readonly PROGRESS_TOTAL: number = 100;

  /**
   * Progress Update speed.
   */
  static readonly PROGRESS_SPEED: number = 2;

  /**
   * Progress Update frequency.
   */
  static readonly UPDATE_FREQUENCY: number = 1000;

  /**
   * Notification id.
   */
  static readonly NOTIFICATION_ID: number = 1000;

  /**
   * The width of download card.
   */
  static readonly CARD_WIDTH: string = '93.3%';

  /**
   * The weight of image.
   */
  static readonly IMAGE_WEIGHT: number = 1;

  /**
   * The weight of card content.
   */
  static readonly CARD_CONTENT_WEIGHT: number = 5;

  /**
   * The width of download content.
   */
  static readonly CARD_CONTENT_WIDTH: string = '70%';

  /**
   * The width of download image.
   */
  static readonly CARD_IMAGE_WIDTH: string = '30%';

  /**
   * The space of column component.
   */
  static readonly SPACE_12 = 12;

  /**
   * The font weight of needed component.
   */
  static readonly FONT_WEIGHT_400 = 400;

  /**
   * The opacity of needed component.
   */
  static readonly OPACITY_4 = 0.4;
  static readonly OPACITY_6 = 0.6;

  /**
   * The ratio of component's width and height.
   */
  static readonly ASPECT_RATIO_176 = 1.76;

  /**
   * The percent of component's width and height.
   */
  static readonly CONTAINER_WIDTH = '100%'
  static readonly CONTAINER_HALF_WIDTH = '49%'
  static readonly CONTAINER_HEIGHT = '100%'
  static readonly BAR_WIDTH = '80%'

  /**
   * The logger tag of outer component.
   */
  static readonly OUTER_TAG = 'Outer';

  /**
   * The order number of tab component.
   */
  static readonly FIRST_TAB = 0;
  static readonly SECOND_TAB = 1;

  /**
   * The animate name of the third library.
   */
  static readonly ANIMATE_NAME = 'data';

  /**
   * The zero frame of the third library.
   */
  static readonly ZERO_FRAME = 0;

}



/**
 * The refresh state enum.
 */
export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}

/**
 * The newsList state enum.
 */
export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}


/**
 * The file upload state enum.
 */
export const enum UploadingState {
  COMPLETE = 'complete',
  FAIL = 'fail'
}

/**
 * The request method enum.
 */
export const enum RequestMethod {
  POST = 'POST',
  GET = 'GET'
}
/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data'
}


/**
 * Download status.
 */
export enum DOWNLOAD_STATUS {
  INITIAL,
  DOWNLOADING,
  PAUSE,
  FINISHED
}

