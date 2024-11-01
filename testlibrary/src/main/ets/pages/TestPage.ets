import { router } from '@kit.ArkUI';

@Entry
@Component
struct TestPage {
  @State message: string = 'HSP back page';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontFamily('HarmonyHeiTi')
          .fontWeight(FontWeight.Bold)
          .fontSize(32)
          // .fontColor($r('app.color.text_color'))
          .margin({ top: '32px' })
          .width('624px')

        Button('Back')
          .id('backToHAP')
          .fontFamily('HarmonyHeiTi')
          .height(48)
          .width('624px')
          .margin({ top: 550 })
          .type(ButtonType.Capsule)
          .borderRadius($r('sys.float.ohos_id_corner_radius_button'))
          // .backgroundColor($r('app.color.text_color'))
          .fontColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .fontSize($r('sys.float.ohos_id_text_size_button1'))
            // 绑定点击事件
          .onClick(() => {
            router.back({ //  返回HAP的页面
              url: 'pages/Index2' // 路径为：`entry/src/main/ets/pages/Index.ets`
            })
          })

        Button($r('app.string.library_title'))
          .id('backToHSP')
          .fontFamily('HarmonyHeiTi')
          .height(48)
          .width('624px')
          .margin({ top: '4%' , bottom: '6%' })
          .type(ButtonType.Capsule)
          .borderRadius($r('sys.float.ohos_id_corner_radius_button'))
          // .backgroundColor($r('app.color.text_color'))
          .fontColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .fontSize($r('sys.float.ohos_id_text_size_button1'))
            // 绑定点击事件
          .onClick(() => {
            router.back({ //  返回HSP的页面
              url: '@bundle:com.samples.hspsample/library/ets/pages/Menu' //路径为：`library/src/main/ets/pages/Menu.ets
            })
          })
      }
      .width('100%')
    }
    // .backgroundColor($r('app.color.text_color'))
    .height('100%')
  }
}