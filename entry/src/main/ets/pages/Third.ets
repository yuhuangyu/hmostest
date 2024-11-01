import Logger from '../common/utils/Logger';
import { uiObserver } from '@kit.ArkUI';
import { UIObserver } from '@kit.ArkUI';

@Entry({routeName : 'ThirdPage'})
@Component
struct Third {
  @State message: string = 'Hello World';
  @State flag: boolean = false;
  @State textColor: Color = Color.Black;
  @State num: number = 0;
  @State toggle: boolean = true;
  @State counter: number = 0;
  @State simpleList: Array<string> = ['one', 'two', 'two', 'three'];
  @State simpleList2: Array<number> = [1, 2, 3, 4, 5];

  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        Logger.info(`Third onPageShow`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        Logger.info(`Third onPageHide`);
      }
    }
  }

  onPageShow() {
    this.num = 5;
  }

  onPageHide() {
    Logger.info("Third onPageHide");
  }

  onBackPress() { // 不设置返回值按照false处理
    this.textColor = Color.Grey;
    this.num = 0;
  }

  aboutToAppear() {
    this.textColor = Color.Blue;
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.on('routerPageUpdate', this.listener);
  }

  aboutToDisappear(): void {
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.off('routerPageUpdate', this.listener);
  }

  build() {
    RelativeContainer() {
      Column() {
        Text(this.message)
          .id('ThirdHelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button() {
          Text('change')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          if (this.flag) {
            this.message = 'Hello World'
          } else {
            this.message = 'change ui'
          }
          Logger.info('flag=   ${this.flag} '+this.flag)
          this.flag = !this.flag
        })

        Text(`num 的值为：${this.num}`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .margin(20)
          .onClick(() => {
            this.num += 5;
          })
        Text(`this page is ${this.queryRouterPageInfo()?.pageId}`)
          .fontSize(25)
        Column() {
          SubComponent()
        }
        if (this.toggle) {
          CounterView({ counter: $counter, label: 'CounterView #positive' })
        } else {
          CounterView({ counter: $counter, label: 'CounterView #negative' })
        }
        Button(`toggle ${this.toggle}`)
          .onClick(() => {
            this.toggle = !this.toggle;
          })
        Text('点击修改第3个数组项的值')
          .fontSize(24)
          .fontColor(Color.Red)
          .onClick(() => {
            this.simpleList[2] = 'new three';
          }).margin({top: 20})
        ForEach(this.simpleList, (item: string) => {
          ChildItem({ item: item }).margin({top: 20})
        }, (item: string) => item)  // (item: string) => item ，这里返回的item一样就不创建
        // ForEach(this.simpleList, (item: string) => {
        //   ChildItem({item: item})
        // }, (item: string) => item)
      }
      .alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Center },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })
    }
    .height('100%')
    .width('100%')
  }

}

@Component
struct SubComponent {
  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        Logger.info(`SubComponent onPageShow`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        Logger.info(`SubComponent onPageHide`);
      }
    }
  }
  aboutToAppear(): void {
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.on('routerPageUpdate', this.listener);
  }
  aboutToDisappear(): void {
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.off('routerPageUpdate', this.listener);
  }
  build() {
    Column() {
      Text(`SubComponent`)
    }
  }
}

@Component
struct CounterView {
  // @State counter: number = 0;
  @Link counter: number; // 保留counter值所做的修改

  label: string = 'unknown';

  build() {
    Column({ space: 20 }) {
      Text(`${this.label}`)
      Button(`counter ${this.counter} +1`)
        .onClick(() => {
          this.counter += 1;
        })
    }
    .margin(10)
    .padding(10)
    .border({ width: 1 })
  }
}

@Component
struct ChildItem {
  @Prop item: string;

  build() {
    Text(this.item)
      .fontSize(50)
  }
}

