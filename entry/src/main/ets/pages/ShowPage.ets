
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

class ArticleClass {
  id: string = '';
  imageSrc: ResourceStr = '';
  title: string = '';
  brief: string = '';
  webUrl: string = '';

  constructor(id: string, imageSrc: ResourceStr, title: string, brief: string, webUrl: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.title = title;
    this.brief = brief;
    this.webUrl = webUrl;
  }
}

@Entry
@Component
struct ShowPage {
  @State message: string = 'Hello World';

  build() {
    Scroll() {
      Column() {
        Banner()
        EnablementView()
        TutorialView()
      }
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}

// @Preview
@Component
struct TutorialItem {
  /*
   * 所以我们使用了@Prop装饰器，该装饰器用于从父组件接收数据。
   * 同时我们也修改各个组件的渲染数据源，使用由父组件传递而来的数据。
   * 此时可以删除之前作为示例文本的title和brief变量。注意此处加入@Prop后，Previewer会失效，
   * 建议开发者直接删掉原来的加在EnablementItem组件上的@Preview装饰器。
   * */
  @Prop tutorialItem: ArticleClass;
  build() {
    Row() {
      Column() {
        Text(this.tutorialItem.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis }) // 设置文本超长时的显示方式，在这里我们设置它的值为Ellipsis，表示超长时使用省略号替代。
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Text(this.tutorialItem.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .margin({ top: 5 })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })

      Image(this.tutorialItem.imageSrc)
        .objectFit(ImageFit.Cover)
        .height(64)
        .width(108)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct EnablementItem {
  @Prop enablementItem: ArticleClass;

  build() {
    Column() {
      // 设置填充效果为cover模式，即保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
      Image(this.enablementItem.imageSrc)
        .width('100%')
        .objectFit(ImageFit.Cover)
        .height(96)
        .borderRadius({
          topLeft: 16,
          topRight: 16
        })
      Text(this.enablementItem.title)
        .height(19)
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .fontWeight(400)
        .padding({ left: 12, right: 12 })
        .margin({ top: 8 })
      Text(this.enablementItem.brief)
        .height(32)
        .width('100%')
        .fontSize(12)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontWeight(400)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 2 })
    }
    .width(160)
    .height(169)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }
}


@Preview
@Component
struct Banner {
  @State bannerList: Array<BannerClass> = [
    new BannerClass('pic0', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/training/course/video/C101718352529709527'),
    new BannerClass('pic1', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/'),
    new BannerClass('pic2', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/deveco-studio/'),
    new BannerClass('pic3', $r('app.media.background'),
      'https://developer.huawei.com/consumer/cn/arkts/'),
    new BannerClass('pic4', $r('app.media.img'),
      'https://developer.huawei.com/consumer/cn/arkui/'),
    new BannerClass('pic5', $r('app.media.img'),
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
    // .vertical()  //
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))  //indicator属性自定义导航点的位置和样式。

  }
}

@Preview
@Component
export struct EnablementView {
  @State enablementList: Array<ArticleClass> = [
    new ArticleClass('1', $r('app.media.img'), 'HarmonyOS第一课',
      '基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-video-courses/video-tutorials-0000001443535745'),
    new ArticleClass('2', $r('app.media.img'), '开发指南',
      '提供系统能力概述、快速入门，用于指导开发者进行场景化的开发。指南涉及到的知识点包括必要的背景知识、符合开发者实际开发场景的操作任务流（开发流程、开发步骤、调测验证）以及常见问题等。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-dev-guide-0000001630265101'),
    new ArticleClass('3', $r('app.media.img'), '最佳实践',
      '针对新发布特性及热点特性提供详细的技术解析和开发最佳实践。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/topic-architecture-0000001678045510'),
    new ArticleClass('4', $r('app.media.img'), 'Codelabs',
      '以教学为目的的代码样例及详细的开发指导，帮助开发者一步步地完成指定场景的应用开发并掌握相关知识。Codelabs将最新的鸿蒙生态应用开发技术与典型场景结合，让开发者快速地掌握开发高质量应用的方法。同时支持互动式操作，通过文字、代码和效果联动为开发者带来更佳的学习体验。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-codelabs/codelabs-0000001443855957'),
    new ArticleClass('5', $r('app.media.img'), 'Sample',
      '面向不同类型的开发者提供的鸿蒙生态应用开发优秀实践，每个Sample Code都是一个可运行的工程，为开发者提供实例化的代码参考。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-samples/samples-0000001162414961'),
    new ArticleClass('6', $r('app.media.img'), 'API参考',
      '面向开发者提供鸿蒙系统开放接口的全集，供开发者了解具体接口使用方法。API参考详细地描述了每个接口的功能、使用限制、参数名、参数类型、参数含义、取值范围、权限、注意事项、错误码及返回值等。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-references/development-intro-0000001580026066'),
    new ArticleClass('7', $r('app.media.img'), 'FAQ',
      '开发者常见问题的总结，开发者可以通过FAQ更高效地解决常见问题。FAQ会持续刷新，及时呈现最新的常见问题。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-faqs/faqs-development-0000001753952202'),
    new ArticleClass('8', $r('app.media.img'), '开发者论坛', '和其他应用开发者交流技术、共同进步。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
  ];

  build() {
    Column() {
      Grid() {
        ForEach(this.enablementList, (item: ArticleClass) => {
          GridItem() {
            EnablementItem({ enablementItem: item })
          }
        }, (item: ArticleClass) => item.id)
      }
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Preview
@Component
struct TutorialView {
  @State tutorialList: Array<ArticleClass> = [
    new ArticleClass('1', $r('app.media.startIcon'), 'Step1 环境的搭建',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('2', $r('app.media.startIcon'), 'Step2 使用Swiper构建运营广告位',
      'Swiper组件提供滑动轮播显示的能力。Swiper本身是一个容器组件，当设置了多个子组件后，可以对这些子组件进行轮播显示。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('3', $r('app.media.startIcon'), 'Step3 创建和组合视图',
      'Item定义子组件相关特征。相关组件支持使用条件渲染、循环渲染、懒加载等方式生成子组件。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('4', $r('app.media.startIcon'), 'Step4 网格和列表组建的使用',
      '网格和列表组件中，当Item达到一定数量，内容超过屏幕大小时，可以自动提供滚动功能，适合用于呈现同类数据类型或数据类型集',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('5', $r('app.media.startIcon'), 'Step5 应用架构设计基础——MVVM模式',
      'ArkUI采取MVVM = Model + View + ViewModel模式，将数据与视图绑定在一起，更新数据的时候直接更新视图。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('6', $r('app.media.startIcon'), 'Step6 应用架构设计基础——三层架构',
      '为了更好地适配复杂应用的开发，建议采用三层架构的方式对整个应用的功能进行模块化，实现高内聚、低耦合开发。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('7', $r('app.media.startIcon'), 'Step6 ArkWeb页面适配',
      'ArkWeb（方舟Web）提供了Web组件，用于在应用程序中显示Web页面内容，为开发者提供页面加载、页面交互、页面调试等能力。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('8', $r('app.media.startIcon'), 'Step7 数据驱动UI更新', '数据更新的同时会直接驱动UI的改变',
      'xxx'),
    new ArticleClass('9', $r('app.media.startIcon'), 'Step8 设置组件导航',
      'Navigation组件适用于模块内页面切换，一次开发，多端部署场景。通过组件级路由能力实现更加自然流畅的转场体验，并提供多种标题栏样式来呈现更好的标题和内容联动效果。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('10', $r('app.media.startIcon'), 'Step9 原生智能：AI语音朗读',
      '文本转语音服务提供将文本信息转换为语音并进行播报的能力，便于用户与设备进行互动，实现实时语音交互，文本播报。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('11', $r('app.media.startIcon'), 'Step10 原生互联：分布式流转',
      '流转能力打破设备界限，多设备联动，使用户应用程序可分可合、可流转，实现如邮件跨设备编辑、多设备协同健身、多屏游戏等分布式业务。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
    new ArticleClass('12', $r('app.media.startIcon'), 'Step11 一次开发，多端部署',
      '一套代码工程，一次开发上架，多端按需部署。支撑开发者快速高效的开发支持多种终端设备形态的应用，实现对不同设备兼容的同时，提供跨设备的流转、迁移和协同的分布式体验。',
      'https://developer.huawei.com/consumer/cn/forum/home?all=1'),
  ];

  build() {
    Column() {
      Text('入门教程')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
      Button({})
      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
          }
        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}
