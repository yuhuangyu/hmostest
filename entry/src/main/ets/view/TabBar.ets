import { CommonConstants } from '../common/constants/CommonConstants';
import NewsTypeModel from '../viewmodel/NewsTypeModel';
import NewsViewModel from '../viewmodel/NewsViewModel';
import NewsList from './NewsList';
import { router } from '@kit.ArkUI';
import { Inner } from './InnerComponent';
import { Outer } from './OuterComponent';

@Component
export default struct TabBar {
  @State tabBarArray: NewsTypeModel[] = NewsViewModel.getDefaultTypeList();
  @State currentIndex: number = 0;
  @State currentPage: number = 1;


  @Builder TabBuilder(index: number) {
    Column() {
      Text(this.tabBarArray[index].name)
        .height(CommonConstants.FULL_HEIGHT)
        .padding({ left: CommonConstants.TabBars_HORIZONTAL_PADDING, right: CommonConstants.TabBars_HORIZONTAL_PADDING })
        .fontSize(this.currentIndex === index ? CommonConstants.TabBars_SELECT_TEXT_FONT_SIZE : CommonConstants.TabBars_UN_SELECT_TEXT_FONT_SIZE)
        .fontWeight(this.currentIndex === index ? CommonConstants.TabBars_SELECT_TEXT_FONT_WEIGHT : CommonConstants.TabBars_UN_SELECT_TEXT_FONT_WEIGHT)
        .fontColor($r('app.color.fontColor_text3'))
    }
  }

  // 在TabBar.ets文件中的aboutToAppear()方法里获取新闻分类。
  // 在NewsList.ets文件中的aboutToAppear()方法里获取新闻数据，将数据加载到新闻列表页面ListLayout布局中。
  // TabBar.ets
  aboutToAppear() {
    // 请求新闻类别
    NewsViewModel.getNewsTypeList().then((typeList: NewsTypeModel[]) => {
      this.tabBarArray = typeList;
    }).catch((typeList: NewsTypeModel[]) => {
      this.tabBarArray = typeList;
    });
  }


  build() {
    Stack() {
      Tabs() {
        ForEach(this.tabBarArray, (tabsItem: NewsTypeModel) => {
          if (tabsItem.id == 1) {
            TabContent() {
              Inner()
            }.tabBar(this.TabBuilder(tabsItem.id))
          } else if (tabsItem.id == 2) {
            TabContent() {
              Outer()
            }.tabBar(this.TabBuilder(tabsItem.id))
          } else {
            TabContent() {
              Column() {
                NewsList({currentIndex: $currentIndex})
              }
            }.tabBar(this.TabBuilder(tabsItem.id))
          }
        })
      }
      .barHeight(CommonConstants.TabBars_BAR_HEIGHT)
      .barWidth(CommonConstants.TabBars_BAR_WIDTH)
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index;
        this.currentPage = 1;
      })
      .vertical(false)

      Image($r('app.media.ic_add'))
        .width($r('app.float.btn_size'))
        .height($r('app.float.btn_size'))
        .margin({ bottom: $r('app.float.btn_margin'), right: $r('app.float.btn_margin') })
        .onClick(() => {
          router.pushUrl({ url: CommonConstants.NEWS_EDIT_PAGE });
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .alignContent(Alignment.BottomEnd)
    .backgroundColor($r('app.color.listColor'))

  }
}