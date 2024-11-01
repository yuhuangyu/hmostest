// 创建NodeController
// common.ets
import { webview } from '@kit.ArkWeb';
import { NodeController, BuilderNode, Size, FrameNode, UIContext } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  // @State message: string = 'Hello World';
  private webviewController: webview.WebviewController = new webview.WebviewController();

  build() {
    // Column() {
    //   // Button('loadUrl')
    //   //   .onClick(() => {
    //   //     try {
    //   //       // 点击按钮时，通过loadUrl，跳转到local1.html
    //   //       // this.controller.loadUrl($rawfile("local1.html"));
    //   //       // this.controller.loadUrl('www.example1.com');
    //   //       this.controller.loadData(
    //   //         "<html><body bgcolor=\"white\">Source:<pre>source</pre></body></html>",
    //   //         "text/html",
    //   //         "UTF-8"
    //   //       );
    //   //
    //   //     } catch (error) {
    //   //       let e: BusinessError= error as BusinessError;
    //   //       Logger.error(`ErrorCode: ${e.code},  Message: ${e.message}`);
    //   //     }
    //   //   })
    //   // 组件创建时，通过$rawfile加载本地文件local.html
    //   // Web({ src: $rawfile("local.html"), controller: this.controller })
    //
    // }
    Row() {
      Column() {
        // NodeContainer用于与NodeController节点绑定，rebuild会触发makeNode
        // Page页通过NodeContainer接口绑定NodeController，实现动态组件页面显示
        // NodeContainer(getNWeb("https://www.example.com"))
        //   .height("90%")
        //   .width("100%")

        // Web({ src: 'http://www.huawei.com', controller: this.webviewController })
        Web({ src: $rawfile('index.html'), controller: this.webviewController })
          .domStorageAccess(true)
          .zoomAccess(false)
          .javaScriptAccess(true)
          // .fileAccess()
          // .imageAccess()
          .onPageEnd(e => {
            try {
              this.webviewController.runJavaScript('test()')
                .then((result) => {
                  console.log('result: ' + result);
                })
                .catch((error: BusinessError) => {
                  console.error("error: " + error);
                })
              if (e) {
                console.info('url: ', e.url);
              }
            } catch (error) {
              let e: BusinessError = error as BusinessError;
              console.error(`ErrorCode: ${e.code},  Message: ${e.message}`);
            }
          })
          .width('100%')
          .aspectRatio(1)
            // 网页调用confirm()告警时触发此回调
          .onConfirm((event) => {
            // 用户定义的弹窗
            AlertDialog.show({
              message: event?.message,
              confirm: {
                value: $r('app.string.title_default_text'),
                action: () => {
                  event?.result.handleConfirm();
                }
              },
              cancel: () => {
                event?.result.handleCancel();
              }
            });
            return true;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

/*
 *
<!-- index.html -->
<!DOCTYPE html>
<html>
  <meta charset="utf-8">
  <body>
      Hello world!
  </body>
  <script type="text/javascript">
  function test() {
      console.log('Ark WebComponent')
      return "This value is from index.html"
  }
  </script>
</html>
 *
 * */
