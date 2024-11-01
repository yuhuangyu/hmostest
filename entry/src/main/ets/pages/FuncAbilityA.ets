import { common } from '@kit.AbilityKit';
import Logger from '../common/utils/Logger';

@Entry
@Component
struct FuncAbilityA {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
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
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          const RESULT_CODE: number = 1001;
          let abilityResult: common.AbilityResult = {
            resultCode: RESULT_CODE,
            want: {
              bundleName: 'com.example.myapplication',
              moduleName: 'entry', // moduleName非必选
              abilityName: 'FuncAbilityB',
              parameters: {
                info: '来自FuncAbility Index页面'
              },
            },
          };
          context.terminateSelfWithResult(abilityResult, (err) => {
            if (err.code) {
              Logger.error(`Failed to terminate self with result. Code is ${err.code}, message is ${err.message}`);
              return;
            }
          });
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