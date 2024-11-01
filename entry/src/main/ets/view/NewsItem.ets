/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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

import { CommonConstants } from '../common/constants/CommonConstants';
import { NewsData, NewsFile } from '../viewmodel/NewsData';

/**
 * The news list item component.
 */
@Component
export default struct NewsItem {
  private newsData: NewsData = new NewsData();

  build() {
    Column() {
      Row() {
        Image($r('app.media.news'))
          .width(CommonConstants.NewsTitle_IMAGE_WIDTH)
          .height(CommonConstants.NewsTitle_IMAGE_HEIGHT)
          .margin({
            top: CommonConstants.NewsTitle_IMAGE_MARGIN_TOP,
            left: CommonConstants.NewsTitle_IMAGE_MARGIN_LEFT
          })
          .objectFit(ImageFit.Fill)
        Text(this.newsData.title)
          .fontSize(CommonConstants.NewsTitle_TEXT_FONT_SIZE)
          .fontColor($r('app.color.fontColor_text'))
          .height(CommonConstants.NewsTitle_TEXT_HEIGHT)
          .width(CommonConstants.NewsTitle_TEXT_WIDTH)
          .maxLines(CommonConstants.NewsTitle_TEXT_MAX_LINES)
          .margin({ left: CommonConstants.NewsTitle_TEXT_MARGIN_LEFT, top: CommonConstants.NewsTitle_TEXT_MARGIN_TOP })
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(CommonConstants.NewsTitle_TEXT_FONT_WEIGHT)
      }

      Text(this.newsData.content)
        .fontSize(CommonConstants.NewsContent_FONT_SIZE)
        .fontColor($r('app.color.fontColor_text'))
        .height(CommonConstants.NewsContent_HEIGHT)
        .width(CommonConstants.NewsContent_WIDTH)
        .maxLines(CommonConstants.NewsContent_MAX_LINES)
        .margin({ left: CommonConstants.NewsContent_MARGIN_LEFT, top: CommonConstants.NewsContent_MARGIN_TOP })
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Grid() {
        ForEach(this.newsData.imagesUrl, (itemImg: NewsFile) => {
          GridItem() {
            Image(CommonConstants.SERVER + itemImg.url)
              .objectFit(ImageFit.Cover)
              .borderRadius(CommonConstants.NewsGrid_IMAGE_BORDER_RADIUS)
          }
        }, (itemImg: NewsFile, index?: number) => JSON.stringify(itemImg) + index)
      }
      .columnsTemplate('1fr '.repeat(this.newsData.imagesUrl.length))
      .columnsGap(CommonConstants.NewsGrid_COLUMNS_GAP)
      .rowsTemplate(CommonConstants.NewsGrid_ROWS_TEMPLATE)
      .width(CommonConstants.NewsGrid_WIDTH)
      .height(CommonConstants.NewsGrid_HEIGHT)
      .margin({ left: CommonConstants.NewsGrid_MARGIN_LEFT, top: CommonConstants.NewsGrid_MARGIN_TOP,
        right: CommonConstants.NewsGrid_MARGIN_RIGHT })

      Text(this.newsData.source)
        .fontSize(CommonConstants.NewsSource_FONT_SIZE)
        .fontColor($r('app.color.fontColor_text2'))
        .height(CommonConstants.NewsSource_HEIGHT)
        .width(CommonConstants.NewsSource_WIDTH)
        .maxLines(CommonConstants.NewsSource_MAX_LINES)
        .margin({ left: CommonConstants.NewsSource_MARGIN_LEFT, top: CommonConstants.NewsSource_MARGIN_TOP })
        .textOverflow({ overflow: TextOverflow.None })
    }
    .alignItems(HorizontalAlign.Start)
  }
}