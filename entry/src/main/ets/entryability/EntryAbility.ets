import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BuilderNode, FrameNode, NodeController, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { webview } from '@kit.ArkWeb';
import { preferences } from '@kit.ArkData';

// let dataPreferences: preferences.Preferences | null = null;

export default class EntryAbility extends UIAbility {
  windowStage: window.WindowStage | undefined = undefined;

  eventFunc(argOne: Context, argTwo: Context): void {
    hilog.info(0x0000, 'testTag', '1. ' + `eventFunc = ${argOne}, ${argTwo}`);
    return;
  }

  // 页面初始化
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // 获取UIAbility实例的上下文
    let context = this.context;
    // AppStorage.setOrCreate('abilityWant', want);
    // 接收调用方UIAbility传过来的参数
    let funcAbilityWant = want;
    let instanceKey = funcAbilityWant?.parameters?.instanceKey;

    hilog.info(0x0000, 'testTag', 'EntryAbility instanceKey =  ' + ` ${instanceKey}`);
    // 获取eventHub
    let eventhub = this.context.eventHub;
    // 执行订阅操作
    eventhub.on('event1', this.eventFunc);
    eventhub.on('event1', (data: string) => {
      // 触发事件，完成相应的业务操作
      hilog.info(0x0000, 'testTag', '1. ' + `eventFunc 触发事件 = ${data}`);
    });
  }

  // 系统资源的释放、数据的保存等
  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {

    // let options: preferences.Options = { name: 'myStore' };
    // dataPreferences = preferences.getPreferencesSync(this.context, options);


    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 设置UI加载
    // windowStage.loadContent方法第一个参数为pages/Index，启动应用会自动加载Index页,可修改。
    windowStage.loadContent('pages/LauncherPage', (err, data) => {

      // 创建Web动态组件（需传入UIContext），loadContent之后的任意时机均可创建
      // createNWeb("https://www.example.com", windowStage.getMainWindowSync().getUIContext());

      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.' + JSON.stringify(data));
    });

    // 设置WindowStage的事件订阅（获焦/失焦、可见/不可见）
    try {
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            hilog.info(0x0000, 'testTag', 'windowStage foreground.');
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            hilog.info(0x0000, 'testTag', 'windowStage active.');
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            hilog.info(0x0000, 'testTag', 'windowStage inactive.');
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            hilog.info(0x0000, 'testTag', 'windowStage background.');
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      hilog.error(0x0000, 'testTag', 'Failed to enable the listener for window stage event changes. Cause:' + JSON.stringify(exception));
    }

    this.windowStage = windowStage;
  }

  // 在WindowStage销毁前执行，此时WindowStage可以使用。
  // 释放通过windowStage对象获取的资源
  onWindowStageWillDestroy(windowStage: window.WindowStage): void {

  }

  // 释放UI资源
  // 例如在onWindowStageDestroy()中注销获焦/失焦等WindowStage事件
  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');

    try {
      if (this.windowStage) {
        this.windowStage.off('windowStageEvent');
      }
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(0x0000, 'testTag', `Failed to disable the listener for windowStageEvent. Code is ${code}, message is ${message}`);
    }
  }

  // 申请系统需要的资源，或者重新申请在onBackground()中释放的资源
  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  // 释放UI不可见时无用的资源，或者在此回调中执行较为耗时的操作
  // 例如状态保存等
  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  // 当应用的UIAbility实例已创建，且UIAbility配置为singleton启动模式时，再次调用startAbility()方法启动该UIAbility实例时，
  // 只会进入该UIAbility的onNewWant()回调，不会进入其onCreate()和onWindowStageCreate()生命周期回调。
  // 应用可以在该回调中更新要加载的资源和数据等，用于后续的UI展示。
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam) {
    // 更新资源、数据


  }

}



/*
// @Builder中为动态组件的具体组件内容
// Data为入参封装类
class Data{
  url: string = "https://www.example.com";
  controller: WebviewController = new webview.WebviewController();
}

@Builder
function WebBuilder(data:Data) {
  Column() {
    Web({ src: data.url, controller: data.controller })
      .width("100%")
      .height("100%")
  }
}


let wrap = wrapBuilder<Data[]>(WebBuilder);

// 用于控制和反馈对应的NodeContainer上的节点的行为，需要与NodeContainer一起使用
export class myNodeController extends NodeController {
  private rootnode: BuilderNode<Data[]> | null = null;
  // 必须要重写的方法，用于构建节点数、返回节点挂载在对应NodeContainer中
  // 在对应NodeContainer创建的时候调用、或者通过rebuild方法调用刷新
  makeNode(uiContext: UIContext): FrameNode | null {
    console.log(" uicontext is undefined : "+ (uiContext === undefined));
    if (this.rootnode != null) {
      // 返回FrameNode节点
      return this.rootnode.getFrameNode();
    }
    // 返回null控制动态组件脱离绑定节点
    return null;
  }
  // 当布局大小发生变化时进行回调
  aboutToResize(size: Size) {
    console.log("aboutToResize width : " + size.width  +  " height : " + size.height )
  }

  // 当controller对应的NodeContainer在Appear的时候进行回调
  aboutToAppear() {
    console.log("aboutToAppear")
  }

  // 当controller对应的NodeContainer在Disappear的时候进行回调
  aboutToDisappear() {
    console.log("aboutToDisappear")
  }

  // 此函数为自定义函数，可作为初始化函数使用
  // 通过UIContext初始化BuilderNode，再通过BuilderNode中的build接口初始化@Builder中的内容
  initWeb(url:string, uiContext:UIContext, control:WebviewController) {
    if(this.rootnode != null)
    {
      return;
    }
    // 创建节点，需要uiContext
    this.rootnode = new BuilderNode(uiContext)
    // 创建动态Web组件
    this.rootnode.build(wrap, { url:url, controller:control })
  }
}
// 创建Map保存所需要的NodeController
let NodeMap:Map<string, myNodeController | undefined> = new Map();
// 创建Map保存所需要的WebViewController
let controllerMap:Map<string, WebviewController | undefined> = new Map();

// 初始化需要UIContext 需在Ability获取
export const createNWeb = (url: string, uiContext: UIContext) => {
  // 创建NodeController
  let baseNode = new myNodeController();
  let controller = new webview.WebviewController() ;
  // 初始化自定义Web组件
  baseNode.initWeb(url, uiContext, controller);
  controllerMap.set(url, controller)
  NodeMap.set(url, baseNode);
}
// 自定义获取NodeController接口
export const getNWeb = (url : string) : myNodeController | undefined => {
  return NodeMap.get(url);
}*/
