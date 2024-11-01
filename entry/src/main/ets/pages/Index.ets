import { router } from '@kit.ArkUI';
import { CommonConstants } from '../common/constants/CommonConstants';
import CommonUtils from '../common/utils/CommonUtils';
import Logger from '../common/utils/Logger';
import { multiplicationTable } from '../common/utils/Method';
import { DaffodilsNumberCustomDialog } from '../view/DaffodilsNumberCustomDialog';
import { IsLeapYearCustomDialog } from '../view/IsLeapYearCustomDialog';
import { IsPalindromicStringCustomDialog } from '../view/IsPalindromicStringCustomDialog';
import { MultiplicationTableCustomDialog } from '../view/MultiplicationTableCustomDialog';
import { StringReversalCustomDialog } from '../view/StringReversalCustomDialog';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { Want } from '@kit.AbilityKit';
import PreferenceModel from '../model/PreferenceModel';
import { ResManager } from 'testlibrary/src/main/ets/ResManager';
import { add } from 'testlibrary';


class routerParams {
  src:string
  constructor(str:string) {
    this.src = str
  }
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  private KEY_NEW = 'KEY';
  scroller: Scroller = new Scroller();
  // context为调用方UIAbility的UIAbilityContext;
  private context = getContext(this) as common.UIAbilityContext;

  daffodilsNumberCustomDialogController: CustomDialogController | null = new CustomDialogController({
    builder: DaffodilsNumberCustomDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: CommonConstants.OFFSET_X, dy: CommonConstants.OFFSET_Y }
  });
  multiplicationTableCustomDialogController: CustomDialogController | null = new CustomDialogController({
    builder: MultiplicationTableCustomDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: CommonConstants.OFFSET_X, dy: CommonConstants.OFFSET_Y }
  });
  isPalindromicStringCustomDialogController: CustomDialogController | null = new CustomDialogController({
    builder: IsPalindromicStringCustomDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: CommonConstants.OFFSET_X, dy: CommonConstants.OFFSET_Y }
  });
  stringReversalCustomDialogController: CustomDialogController | null = new CustomDialogController({
    builder: StringReversalCustomDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: CommonConstants.OFFSET_X, dy: CommonConstants.OFFSET_Y }
  });
  isLeapYearCustomDialogController: CustomDialogController | null = new CustomDialogController({
    builder: IsLeapYearCustomDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: CommonConstants.OFFSET_X, dy: CommonConstants.OFFSET_Y }
  });
  // private context = getContext(this) as entryability.EntryAbility
  build() {
    Scroll(this.scroller) {
      Column() {
        // Image($r('app.media.img'))
        //   .objectFit(ImageFit.Contain)
        //   .width('100%')
        //   .padding({ top: 11, left: 16, right: 16 })
        //   .borderRadius(16)
        Text($r('app.string.ArkTS_Development_Case'))
          .width(CommonConstants.PERCENT_NINETY)
          .margin({
            top: $r('app.float.text_margin_right'),
            bottom: $r('app.float.text_margin_bottom'),
            left: $r('app.float.text_margin_left'),
            right: $r('app.float.text_margin_right')
          })
          .font({ size: $r('app.float.text_font_size'), weight: CommonConstants.FONT_WEIGHT_SEVEN_HUNDRED })
        Column() {
          Button($r('app.string.DaffodilsNumber'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .onClick(() => {
              this.daffodilsNumberCustomDialogController?.open();
            })
          Button($r('app.string.MultiplicationTable'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({ top: $r('app.float.button_margin_top') })
            .onClick(() => {
              this.multiplicationTableCustomDialogController?.open();
              let result = multiplicationTable();
              for (let index = 0; index < result.length; index++) {
                Logger.info(result[index].toString());
              }
            })
          Button($r('app.string.IsPalindromicString'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({ top: $r('app.float.button_margin_top') })
            .onClick(() => {
              this.isPalindromicStringCustomDialogController?.open();
            })
          Button($r('app.string.StringReversal'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({ top: $r('app.float.button_margin_top') })
            .onClick(() => {
              this.stringReversalCustomDialogController?.open();
            })
          Button($r('app.string.IsLeapYear'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              this.isLeapYearCustomDialogController?.open();
            })
          Button($r('app.string.check_to_second'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              // router.pushUrl({url: 'pages/Second'}).then(() => {
              router.pushUrl({url: 'pages/ShowPage'}).then(() => {
                Logger.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })
            })
          Button($r('app.string.check_to_third'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              router.pushUrl({url: 'pages/Third'}).then(() => {
                Logger.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })
            })
          Button($r('app.string.check_to_fourth'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              router.pushUrl({url: 'pages/ArticleListView'}).then(() => {
                Logger.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })
            })
          Button($r('app.string.check_to_foreachsort'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              router.pushUrl({url: 'pages/ForEachSort'}).then(() => {
                Logger.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })
            })
          Button($r('app.string.page_todo'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ToDoListPage',
                params: new routerParams("test001")
              }).then(() => {
                Logger.info('Succeeded in jumping to the second page.')
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })

              // eventOff()
            })
          Button($r('app.string.page_uiability'))
            .width($r('app.float.button_width'))
            .height($r('app.float.button_height'))
            .margin({
              top: $r('app.float.button_margin_top'),
              bottom: $r('app.float.button_margin_bottom')
            })
            .onClick(() => {

              // let want: Want = {
              //   deviceId: '', // deviceId为空表示本设备
              //   bundleName: "com.example.myapplication",
              //   abilityName: 'EntryAbility',
              //   moduleName: 'entry', // moduleName非必选
              //   parameters: {
              //     // 自定义信息
              //     instanceKey: this.KEY_NEW
              //   }
              // };
              // this.context.startAbility(want).then(() => {
              //   Logger.info('Succeeded in starting SpecifiedAbility.');
              // }).catch((err: BusinessError) => {
              //   Logger.error(`Failed to start SpecifiedAbility. Code is ${err.code}, message is ${err.message}`);
              // })
              // this.KEY_NEW = this.KEY_NEW + 'a';

              // this.eventHubFunc();
              // CommonUtils.showToast("EventHubFuncA");

              // router.pushUrl({url: 'pages/LocalStoragePage'})

              // 在FuncAbility业务完成之后，如需要停止当前UIAbility实例，在FuncAbility中通过调用terminateSelf()方法实现。
              // context为需要停止的UIAbility实例的AbilityContext
              // this.context.terminateSelf((err) => {
              //   if (err.code) {
              //     Logger.error(`Failed to terminate self. Code is ${err.code}, message is ${err.message}`);
              //     return;
              //   }
              // });

              // const RESULT_CODE: number = 1001;
              // let want: Want = {
              //   deviceId: '', // deviceId为空表示本设备
              //   bundleName: 'com.example.myapplication',
              //   moduleName: 'entry', // moduleName非必选
              //   abilityName: 'FuncAbilityA',
              //   parameters: {
              //     // 自定义信息
              //     info: '来自EntryAbility UIAbilityComponentsInteractive页面',
              //     router: 'pages/FuncAbilityA'
              //   }
              // };
              // this.context.startAbilityForResult(want).then((data) => {
              //   if (data?.resultCode === RESULT_CODE) {
              //     // 解析被调用方UIAbility返回的信息
              //     let info = data.want?.parameters?.info;
              //     Logger.info(JSON.stringify(info) ?? '');
              //     if (info !== null) {
              //       CommonUtils.showToast(JSON.stringify(info));
              //     }
              //   }
              //   Logger.error(JSON.stringify(data.resultCode) ?? '');
              // })
              router.pushUrl({url: 'pages/WebComponent'})

            })
        }.width(CommonConstants.PERCENT_FULL)
      }.width(CommonConstants.PERCENT_FULL)
    }
    .align(Alignment.TopStart)
    .constraintSize({ minHeight: '100%' })
    .edgeEffect(EdgeEffect.Spring)
    .scrollable(ScrollDirection.Vertical)  // Vertical表示允许纵向滚动
    .scrollBar(BarState.Auto)  // scrollBar属性表示以何种方式显示滚动条,支持一直显示、不显示以及滑动时显示，此处设为BarState.Auto表示滑动时显示。
    .backgroundColor('#F1F3F5')

  }

  // 触发事件
  eventHubFunc(): void {
    // 不带参数触发自定义“event1”事件
    this.context.eventHub.emit('event1');
    // 带1个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 1);
    // 带2个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 2, 'test');
    // 开发者可以根据实际的业务场景设计事件传递的参数
  }

  // 取消该事件的订阅
  eventOff(): void {
    this.context.eventHub.off('event1');
  }


  test() {
    // let x: number = null;    // 编译时错误
    // let y: string = null;    // 编译时错误
    // let z: number[] = null;  // 编译时错误

    let x: number | null = null;

    CommonUtils.showToast(CommonConstants.STRING_INPUT);
    Logger.info("aaa ")


    // let para: Record<string,number> = { 'PropA': 47 };
    // let storage: LocalStorage = new LocalStorage(para); // 创建新实例并使用给定对象初始化
    // let propA: number | undefined = storage.get('PropA') // propA == 47
    // let link1: SubscribedAbstractProperty<number> = storage.link('PropA'); // link1.get() == 47
    // let link2: SubscribedAbstractProperty<number> = storage.link('PropA'); // link2.get() == 47
    // let prop: SubscribedAbstractProperty<number> = storage.prop('PropA'); // prop.get() == 47
    // link1.set(48); // two-way sync: link1.get() == link2.get() == prop.get() == 48
    // prop.set(1); // one-way sync: prop.get() == 1; but link1.get() == link2.get() == 48
    // link1.set(49); // two-way sync: link1.get() == link2.get() == prop.get() == 49

    // @LocalStorageLink 双向绑定
    // @LocalStorageProp 单向绑定
    //  LocalStoragePage页面例子


    // AppStorage是单例，它的所有API都是静态的，使用方法类似于LocalStorage中对应的非静态方法。
    AppStorage.setOrCreate('PropA', 47);

    let storage: LocalStorage = new LocalStorage();
    storage.setOrCreate('PropA',17);
    let propA: number | undefined = AppStorage.get('PropA') // propA in AppStorage == 47, propA in LocalStorage == 17
    let link1: SubscribedAbstractProperty<number> = AppStorage.link('PropA'); // link1.get() == 47
    let link2: SubscribedAbstractProperty<number> = AppStorage.link('PropA'); // link2.get() == 47
    let prop: SubscribedAbstractProperty<number> = AppStorage.prop('PropA'); // prop.get() == 47

    link1.set(48); // two-way sync: link1.get() == link2.get() == prop.get() == 48
    prop.set(1); // one-way sync: prop.get() == 1; but link1.get() == link2.get() == 48
    link1.set(49); // two-way sync: link1.get() == link2.get() == prop.get() == 49

    storage.get<number>('PropA') // == 17
    storage.set('PropA', 101);
    storage.get<number>('PropA') // == 101

    AppStorage.get<number>('PropA') // == 49
    link1.get() // == 49
    link2.get() // == 49
    prop.get() // == 49


    // 此处以此键值对不存在时写入数据为例
    // dataPreferences.putSync('startup', 'auto');

    // await PreferenceModel.getPreferencesFromStorage();
    // ResManager

  }
}