import { add } from 'testlibrary/src/main/ets/utils/Calc';
import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import TabBar from '../view/TabBar';

@Entry
@Component
struct Index2 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      TabBar()
    }
    .height(CommonConstants.FULL_WIDTH)
    .backgroundColor($r('app.color.listColor'))

  }

  aboutToAppear(): void {
    let aaa = add(3,5);
    Logger.info( ' aboutToAppear aaa = '+aaa)
  }
}