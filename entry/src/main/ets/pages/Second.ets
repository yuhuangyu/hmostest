import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/utils/Logger';



class BannerClass{
  id: string = '';
  imageSrc: ResourceStr = '';
  url: string = '';

  constructor(id: string, imageSrc: ResourceStr, url: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.url = url;
  }

}
@Entry
@Component
struct Second {
  @State message: string = 'Hello World';
  @State showChild: boolean = true;
  @State btnColor:string = "#FF007DFF";
  @State changeFontSize: number = 22;

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    Logger.info('Second onPageShow');
  }
  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    Logger.info('Second onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    Logger.info('Second onBackPress');
    this.btnColor ="#FFEE0606";
    return true // 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
  }

  // 组件生命周期
  aboutToAppear() {
    Logger.info('Second aboutToAppear');
  }

  // 组件生命周期
  onDidBuild() {
    Logger.info('Second onDidBuild');
  }

  // 组件生命周期
  aboutToDisappear() {
    Logger.info('Second aboutToDisappear');
  }

  build() {
    RelativeContainer() {
      Column() {
        // Banner()
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin({
            top: 20
          })

        Button() {
          Text('Back')
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
          Logger.info(" suc back")
          try {
            router.back()
            Logger.info(" suc back")
          } catch (err) {
            let code = (err as BusinessError).code;
            let message = (err as BusinessError).message;
            Logger.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })

        // this.showChild为true，创建Child子组件，执行Child aboutToAppear
        if (this.showChild) {
          Child()
        }
        // this.showChild为false，删除Child子组件，执行Child aboutToDisappear
        Button('delete Child')
          .margin(20)
          .backgroundColor(this.btnColor)
          .onClick(() => {
            this.showChild = false;
          })
        // push到page页面，执行onPageHide
        Button('push to next page')
          .onClick(() => {
            router.pushUrl({ url: 'pages/Third' });
          })

        Slider({
          value: this.changeFontSize,
          min: 14,
          max: 22,
          step: 2,
          style: SliderStyle.InSet
        })
          .showSteps(true)
          .width("75%")
          .onChange(async (value: number) => {
            this.changeFontSize = value;
          })
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
struct Child {
  @State title: string = 'Hello World';
  // 组件生命周期
  aboutToDisappear() {
    Logger.info('[lifeCycle] Child aboutToDisappear')
  }

  // 组件生命周期
  onDidBuild() {
    Logger.info('[lifeCycle] Child onDidBuild');
  }

  // 组件生命周期
  aboutToAppear() {
    Logger.info('[lifeCycle] Child aboutToAppear')
  }

  build() {
    Text(this.title)
      .fontSize(50)
      .margin(20)
      .onClick(() => {
        this.title = 'Hello ArkUI';
      })
  }
}

// entry/src/main/ets/pages/Index.ets

@Preview
@Component
struct Banner {
  @State bannerList: Array<BannerClass> = [
    new BannerClass('pic0', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/training/course/video/C101718352529709527'),
    new BannerClass('pic1', $r('app.media.startIcon'),
      'https://developer.huawei.com/consumer/cn/'),
    new BannerClass('pic2', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/deveco-studio/'),
    new BannerClass('pic3', $r('app.media.background'),
      'https://developer.huawei.com/consumer/cn/arkts/'),
    new BannerClass('pic4', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/arkui/'),
    new BannerClass('pic5', $r('app.media.background'),
      'https://developer.huawei.com/consumer/cn/sdk')
  ];

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass, index: number) => {
        Image(item.imageSrc)
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(16)
      }, (item: BannerClass, index: number) => item.id)
    }
    .autoPlay(true)  // utoPlay控制是否自动轮播子组件
    .loop(true)     // loop属性控制是否循环播放
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))  //indicator属性自定义导航点的位置和样式。

  }
}