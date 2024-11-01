import { uiObserver } from "@kit.ArkUI";

@Entry
@Component
struct HomePage {
  // @State TooTmp: ToolbarItem = {'value': "func", 'icon': "./image/ic_public_highlights.svg", 'action': ()=> {}}
  @State TooTmp: ToolbarItem = {'value': "func", 'icon': "resources/base/media/ic_ok.png", 'action': ()=> {}}
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  private arr: number[] = [1, 2, 3];

  @Builder
  PageMap(name: string) {
    if (name == 'DialogPage') {
      DialogPage()
    } else if (name === "NavDestinationTitle1") {
      pageOneTmp()
    } else if (name === "NavDestinationTitle2") {
      pageTwoTmp()
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp()
    }
  }

  // 创建一个页面栈对象并传入Navigation
  // 每个Navigation都需要创建并传入一个NavPathStack对象，用于管理页面。
  // 主要涉及页面跳转、页面返回、页面替换、页面删除、参数获取、路由拦截等功能。
  pageStack: NavPathStack = new NavPathStack()
  build() {
    Column() {
      Navigation(this.pageStack) {

        Button('Push DialogPage')
          .margin(20)
          .width('80%')
          .onClick(() => {
            this.pageStack.pushPathByName('DialogPage', '');
          })

        // TextInput({ placeholder: 'search...' })
        //   .width("90%")
        //   .height(40)
        //   .backgroundColor('#FFFFFF')
        //
        // List({ space: 12 }) {
        //   ForEach(this.arr, (item:string) => {
        //     ListItem() {
        //       Text("NavRouter" + item)
        //         .width("100%")
        //         .height(72)
        //         .backgroundColor('#FFFFFF')
        //         .borderRadius(24)
        //         .fontSize(16)
        //         .fontWeight(500)
        //         .textAlign(TextAlign.Center)
        //         .onClick(()=>{
        //           this.pageInfos.pushPath({ name: "NavDestinationTitle" + item})
        //         })
        //     }
        //   }, (item:string):string => item)
        // }
        // .width("90%")
        // .margin({ top: 12 })
      }
      .titleMode(NavigationTitleMode.Mini)  // Full\ Mini
      .title("主标题")
      // 将mode属性为NavigationMode.Auto，为自适应模式，即当设备宽度大于520vp时，Navigation组件采用分栏模式，反之采用单页面模式。
      // 将mode属性设置为NavigationMode.Stack，Navigation组件即可设置为单页面显示模式。
      // 将mode属性设置为NavigationMode.Split，Navigation组件即可设置为分栏显示模式。
      .mode(NavigationMode.Stack)
      .navDestination(this.PageMap)
      // .menus([
      //   {value: "", icon: "resources/base/media/ic_ok.png", action: ()=> {
      //
      //   }},
      //   {value: "", icon: "resources/base/media/startIcon.png", action: ()=> {}}
      //   // {value: "", icon: "./image/ic_public_add.svg", action: ()=> {}}
      // ])   // 右上图标
      // .toolbarConfiguration([this.TooTmp, this.TooTmp, this.TooTmp])  //底部图标
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

@Component
export struct DialogPage {
  @Consume('NavPathStack') pageStack: NavPathStack;
  // navDesInfo: uiObserver.NavDestinationInfo | undefined




  aboutToAppear(): void {
    // this.navDesInfo = this.queryNavDestinationInfo();
    this.pageStack.disableAnimation(true) // disableAnimation方法可以在当前Navigation中关闭或打开所有转场动画。


    // NavPathStack中提供的Push、Pop、Replace等接口中可以设置animated参数，默认为true表示有转场动画
    // this.pageStack.pushPath({ name: "PageOne" }, false)
    // this.pageStack.pop(false)   // 单次关闭转场动画可以置为false
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          // Text("所属页面Name: " + this.navDesInfo?.name)
          Text("Dialog NavDestination")
            .fontSize(20)
            .margin({ bottom: 100 })
          Button("Close").onClick(() => {
            this.pageStack.pop()
          }).width('30%')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height('30%')
        .width('80%')
      }.height("100%").width('100%')
    }
    .backgroundColor('rgba(0,0,0,0.5)')
    .hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
  }
}

// PageOne.ets
@Component
export struct pageOneTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent1")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle1")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageTwo.ets
@Component
export struct pageTwoTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent2")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle2")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
      .geometryTransition('sharedId') // 通过geometryTransition实现共享元素转场。配置了共享元素转场的页面同时需要关闭系统默认的转场动画。
      // 为需要实现共享元素转场的组件添加geometryTransition属性，id参数必须在两个NavDestination之间保持一致。
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}