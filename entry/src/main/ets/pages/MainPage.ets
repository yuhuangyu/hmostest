
@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World';


  build() {
    Column() {
      tabView()
    }
    // .height('100%')
    // .width('100%')
  }

}

@Component
struct tabView{
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController()

  build() {

    Column() {
      // 默认 BarPosition.Start 顶部或左边
      Tabs({ barPosition: BarPosition.End , controller: this.controller, index: this.currentIndex}) {

        TabContent() {
          // Column(){
          //   Text('首页的内容')
          // }
          // .width('100%')
          // .height('100%')
          // .backgroundColor('#007DFF')
          // HomePage()

        }
        .tabBar(this.tabBuilder('首页', 0, $r('app.media.startIcon'), $r('app.media.foreground')))

        TabContent() {
          Column(){
            Text('发现的内容')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#007DFF')
        }
        .tabBar(this.tabBuilder('发现', 1, $r('app.media.startIcon'), $r('app.media.foreground')))

        TabContent() {
          Column(){
            Text('推荐的内容')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#007DFF')
        }
        .tabBar(this.tabBuilder('推荐', 2, $r('app.media.startIcon'), $r('app.media.foreground')))

        TabContent() {
          Column(){
            Text('我的内容')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#007DFF')
        }
        .tabBar(this.tabBuilder('我的', 3, $r('app.media.startIcon'), $r('app.media.foreground')))

      }
      .barMode(BarMode.Fixed)   // 控制导航栏是否可以滚动，默认值为BarMode.Fixed 不可滚动， Scrollable可滚动
      .scrollable(false) // 禁止滑动
      .vertical(false)  // 侧边导航栏 vertical=true，vertical默认值为false，表明内容页和导航栏垂直方向排列。
      .animationDuration(0)
      .backgroundColor('#F1F3F5')
      .onChange((index: number) => {
        this.currentIndex = index
      })
      // 设置自定义拦截回调函数。拦截回调函数在下一个页面即将展示时被调用，
      // 如果回调返回true，新页面可以展示；如果回调返回false，新页面不会展示，仍显示原来页面。
      .onContentWillChange((currentIndex, comingIndex) => {
        if (comingIndex == 2) {
          return false
        }
        return true
      })
      .height(600)
      // .barWidth(100)
      // .barHeight(200)
      //  vertical为false时，tabbar的宽度默认为撑满屏幕的宽度，需要设置barWidth为合适值。
      //  vertical为true时，tabbar的高度默认为实际内容的高度，需要设置barHeight为合适值。

      Button('动态修改index').width('50%').margin({ top: 20 })
        .onClick(()=>{
          this.currentIndex = (this.currentIndex + 1) % 4
        })

      Button('changeIndex').width('50%').margin({ top: 20 })
        .onClick(()=>{
          let index = (this.currentIndex + 1) % 4
          this.controller.changeIndex(index)
        })
    }

  }

  @Builder tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

}

