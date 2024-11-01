import { CommonConstants, PageState } from '../common/constants/CommonConstants';
import { CustomRefreshLoadLayoutClass, NewsData } from '../viewmodel/NewsData';
import NewsModel from '../viewmodel/NewsModel';
import NewsViewModel from '../viewmodel/NewsViewModel';
import { promptAction, router } from '@kit.ArkUI';
import CustomRefreshLoadLayout from './CustomRefreshLoadLayout';
import RefreshLayout from './RefreshLayout';
import NewsItem from './NewsItem';
import NoMoreLayout from './NoMoreLayout';
import { listTouchEvent } from '../common/utils/PullDownRefresh';
import { BusinessError } from '@kit.BasicServicesKit';
import { HARMainPage } from 'staticlibrary/src/main/ets/components/HARMainPage';

@Component
export default struct NewsList {
  @State newsModel: NewsModel = new NewsModel();
  @Watch('changeCategory') @Link currentIndex: number;

  changeCategory() {
    this.newsModel.currentPage = 1;
    NewsViewModel.getNewsList(this.newsModel.currentPage, this.newsModel.pageSize, CommonConstants.GET_NEWS_LIST).then((data: NewsData[]) => {
      this.newsModel.pageState = PageState.Success;
      if (data.length === this.newsModel.pageSize) {
        this.newsModel.currentPage++;
        this.newsModel.hasMore = true;
      } else {
        this.newsModel.hasMore = false;
      }
      this.newsModel.newsData = data;
    }).catch((err: string | Resource) => {
      promptAction.showToast({
        message: err,
        duration: CommonConstants.ANIMATION_DURATION
      });
      this.newsModel.pageState = PageState.Fail;
    });
  }

  aboutToAppear() {
    // 请求新闻数据
    this.changeCategory();
  }


  build() {
    Column() {
      if(this.newsModel.pageState === PageState.Success){
        this.ListLayout()
      } else if(this.newsModel.pageState === PageState.Loading) {
        this.LoadingLayout()
      } else if(this.newsModel.pageState === PageState.Fail) {
        this.FailLayout()
      }
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .justifyContent(FlexAlign.Center)
    .onTouch((event?: TouchEvent) => {
      if (event) {
        if (this.newsModel.pageState === PageState.Success) {
          listTouchEvent(this.newsModel, event);
        }
      }
    })
  }

  @Builder FailLayout() {
    Image($r('app.media.none'))
      .height(CommonConstants.NewsListConstant_NONE_IMAGE_SIZE)
      .width(CommonConstants.NewsListConstant_NONE_IMAGE_SIZE)

    Text($r('app.string.page_none_msg'))
      .opacity(CommonConstants.NewsListConstant_NONE_TEXT_opacity)
      .fontSize(CommonConstants.NewsListConstant_NONE_TEXT_size)
      .fontColor($r('app.color.fontColor_text3'))
      .margin({ top: CommonConstants.NewsListConstant_NONE_TEXT_margin })

    Button($r('app.string.check_to_second'))
      .width($r('app.float.button_width'))
      .height($r('app.float.button_height'))
      .margin({ top: $r('app.float.button_margin_top') })
      .onClick(() => {
        router.pushUrl({
          url: '@bundle:com.example.myapplication/testlibrary/ets/pages/TestPage'
        }).then(() => {
          console.log('push page success');
        }).catch((err: BusinessError) => {
          console.error('pushUrl failed, code is' + err.code + ', message is' + err.message);
        })
      })

    Button($r('app.string.check_to_third'))
      .width($r('app.float.button_width'))
      .height($r('app.float.button_height'))
      .margin({ top: $r('app.float.button_margin_top') })
      .onClick(() => {
        router.pushUrl({ url: "pages/NotificationPage" });
      })

    // 引用HAR的ArkUI组件
    HARMainPage()
  }

  @Builder LoadingLayout() {
    CustomRefreshLoadLayout({ customRefreshLoadClass: new CustomRefreshLoadLayoutClass(true,
      $r('app.media.ic_pull_up_load'), $r('app.string.pull_up_load_text'), this.newsModel.pullDownRefreshHeight) })
  }

  @Builder ListLayout() {
    List() {
      ListItem() {
        RefreshLayout({
          refreshLayoutClass: new CustomRefreshLoadLayoutClass(this.newsModel.isVisiblePullDown, this.newsModel.pullDownRefreshImage,
            this.newsModel.pullDownRefreshText, this.newsModel.pullDownRefreshHeight)
        })
      }

      ForEach(this.newsModel.newsData, (item: NewsData) => {
        ListItem() {
          NewsItem({newsData: item})
        }
        .height(CommonConstants.NewsListConstant_ITEM_HEIGHT)
        .backgroundColor($r('app.color.white'))
        .margin({ top: CommonConstants.NewsListConstant_ITEM_MARGIN_TOP })
        .borderRadius(CommonConstants.NewsListConstant_ITEM_BORDER_RADIUS)
      }, (item: NewsData, index: number) => JSON.stringify(item) + index)

      ListItem() {
        if (this.newsModel.hasMore) {
          RefreshLayout({
            refreshLayoutClass: new CustomRefreshLoadLayoutClass(this.newsModel.isVisiblePullUpLoad, this.newsModel.pullUpLoadImage,
              this.newsModel.pullUpLoadText, this.newsModel.pullUpLoadHeight)
          })
        } else {
          NoMoreLayout()
        }

      }

    }

  }
}
