import { notificationManager } from '@kit.NotificationKit';
import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { wantAgent, Want, common } from '@kit.AbilityKit';
import { WantAgent } from '@ohos.wantAgent';
import { createWantAgent, openNotificationPermission, publishNotification } from '../common/utils/NotificationUtil';
import { CommonConstants, DOWNLOAD_STATUS } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';


@Entry
@Component
struct NotificationPage {
  @State message: string = 'Hello World';
  @State progress: number = 0;

  @State downloadStatus: number = DOWNLOAD_STATUS.INITIAL;
  @State downloadProgress: number = 0;
  private context = getContext(this) as common.UIAbilityContext;
  private isSupport: boolean = true;
  private notificationTitle: string = '';
  private wantAgentObj: object = new Object();
  private interval: number = -1;

  aboutToAppear() {
    openNotificationPermission();
    let bundleName = this.context.abilityInfo.bundleName;
    let abilityName = this.context.abilityInfo.name;
    createWantAgent(bundleName, abilityName).then(want => {
      this.wantAgentObj = want;
    }).catch((err: Error) => {
      Logger.error(`getWantAgent fail, err: ${JSON.stringify(err)}`);
    });
    notificationManager.isSupportTemplate('downloadTemplate').then(isSupport => {
      if (!isSupport) {
        // promptAction.showToast({
        //   message: $r('app.string.invalid_button_toast')
        // })
      }
      this.isSupport = isSupport;
    });
  }

  onBackPress() {
    this.cancel();
  }


  /**
   * Start the timer and send notification.
   */
  download() {
    this.interval = setInterval(async () => {
      if (this.downloadProgress === CommonConstants.PROGRESS_TOTAL) {
        this.notificationTitle = await getStringByRes($r('app.string.notification_title_finish'), this);
        this.downloadStatus = DOWNLOAD_STATUS.FINISHED;
        clearInterval(this.interval);
      } else {
        this.downloadProgress += CommonConstants.PROGRESS_SPEED;
      }
      if (this.isSupport) {
        publishNotification(this.downloadProgress, this.notificationTitle, this.wantAgentObj);
      }
    }, CommonConstants.UPDATE_FREQUENCY);
  }

  /**
   * Click to download.
   */
  async start() {
    this.notificationTitle = await getStringByRes($r('app.string.notification_title_download'), this);
    this.downloadStatus = DOWNLOAD_STATUS.DOWNLOADING;
    this.downloadProgress = 0;
    this.download();
  }

  /**
   * Click pause.
   */
  async pause() {
    this.notificationTitle = await getStringByRes($r('app.string.notification_title_pause'), this);
    clearInterval(this.interval);
    this.downloadStatus = DOWNLOAD_STATUS.PAUSE;
    if (this.isSupport) {
      publishNotification(this.downloadProgress, this.notificationTitle, this.wantAgentObj);
    }
  }

  /**
   * Click resume.
   */
  async resume() {
    this.notificationTitle = await getStringByRes($r('app.string.notification_title_download'), this);
    this.download();
    this.downloadStatus = DOWNLOAD_STATUS.DOWNLOADING;
  }

  /**
   * Click cancel.
   */
  async cancel() {
    this.downloadProgress = 0;
    clearInterval(this.interval);
    this.downloadStatus = DOWNLOAD_STATUS.INITIAL;
    notificationManager.cancel(CommonConstants.NOTIFICATION_ID);
  }

  /**
   * Open file
   */
  open() {
    promptAction.showToast({
      message: $r('app.string.invalid_button_toast')
    })
  }

  @Builder
  customButton(textResource: Resource, click: Function = () => {
  }) {
    Button(textResource)
      .backgroundColor($r('app.color.button_color'))
      .buttonsStyle()
      .onClick(() => {
        click();
      })
  }

  @Builder
  cancelButton() {
    Button($r('app.string.button_cancel'))
      .buttonsStyle()
      .backgroundColor($r('app.color.cancel_button_color'))
      .fontColor($r('app.color.button_color'))
      .margin({ right: $r('app.float.button_margin') })
      .onClick(() => {
        this.cancel();
      })
  }

  /*publishNotification() {

    try {
      wantAgent.getWantAgent(wantAgentInfo, getWantAgentCallback);
    } catch (err) {
      console.error(`getWantAgent failed, error: ${JSON.stringify(err)}`);
    }

    let notificationRequest: notificationManager.NotificationRequest = { // 描述通知的请求
      id: 1, // 通知ID
      groupName:'ChatGroup', // 通过设置字段groupName，就可以对通知进行分组，给groupName设置不同的值可以将通知分为不同的组。
      content: { // 通知内容
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
        normal: { // 基本类型通知内容
          title: '通知内容标题',
          text: '通知内容详情'
        }
      },
      wantAgent: wantAgentData
    }
    notificationManager.publish(notificationRequest).then(() => { // 发布通知
      console.info('publish success');
    }).catch((err: Error) => {
      console.error(`publish failed,message is ${err}`);
    });


    // 在发布进度类型通知前需要查询系统是否支持进度条模板。
    notificationManager.isSupportTemplate('downloadTemplate').then(isSupport => {
      if (!isSupport) {
        // promptAction.showToast({
        //   message: $r('app.string.invalid_button_toast')
        // })
      }
      this.isSupport = isSupport;
    });

    this.progress = 60;
    let template: notificationManager.NotificationTemplate = {
      name: 'downloadTemplate',
      data: {
        progressValue: this.progress, // 当前进度值
        progressMaxValue: 100 // 最大进度值
      }
    }

    // 进度条
    // let notificationRequest: notificationManager.NotificationRequest = {
    //   id: 1,
    //   content: {
    //     notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
    //     normal: {
    //       title: '文件下载：music.mp4',
    //       text: 'senTemplate',
    //       additionalText: '60%'
    //     }
    //   },
    //   template: template,
    // }

    // 通过通知通道，您可让通知有不同的表现形式，比如社交类型的通知是横幅显示的，并且有提示音，
    // 而一般的通知则不会横幅显示，您可以使用slotType来实现，设置slotType为SlotType.SOCIAL_COMMUNICATION，表示为社交类型通知。
    // 示例代码如下：
    // SlotType.SOCIAL_COMMUNICATION：社交类型，状态栏中显示通知图标，有横幅和提示音。
    // SlotType.SERVICE_INFORMATION：服务类型，状态栏中显示通知图标，没有横幅但有提示音。
    // SlotType.CONTENT_INFORMATION：内容类型，状态栏中显示通知图标，但没有横幅或提示音。
    // SlotType.OTHER_TYPES：其它类型，状态栏中不显示通知图标，且没有横幅或提示音。
    notificationManager.addSlot(notificationManager.SlotType.SOCIAL_COMMUNICATION).then(() => {
      console.info("addSlot success");
    }).catch((err: BusinessError) => {
      console.error(`addSlot fail: ${JSON.stringify(err)}`);
    });

    // 发布通知
    notificationManager.publish(notificationRequest).then(() => {
      console.info(`publish success`);
    }).catch((err: Error) => {
      console.error(`publish failed,message is ${err}`);
    })


    // // 通过通知ID和通知标签取消已发布的通知。
    // notificationManager.cancel(notificationId)
    //
    // // 取消所有已发布的通知。
    // notificationManager.cancelAll()



  }*/

  build() {
    Column() {
      Text($r('app.string.title'))
        .fontSize($r('app.float.title_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_LAGER)
        .width(CommonConstants.TITLE_WIDTH)
        .textAlign(TextAlign.Start)
        .margin({
          top: $r('app.float.title_margin_top'),
          bottom: $r('app.float.title_margin_top')
        })
      Row() {
        Column() {
          Image($r('app.media.ic_image'))
            .objectFit(ImageFit.Fill)
            .width($r('app.float.card_image_length'))
            .height($r('app.float.card_image_length'))
        }
        .layoutWeight(CommonConstants.IMAGE_WEIGHT)
        .height(CommonConstants.FULL_LENGTH)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Row() {
            Text(CommonConstants.DOWNLOAD_FILE)
              .fontSize($r('app.float.name_font_size'))
              .textAlign(TextAlign.Center)
              .fontWeight(CommonConstants.FONT_WEIGHT_LAGER)
              .lineHeight($r('app.float.name_font_height'))
            Text(`${this.downloadProgress}%`)
              .fontSize($r('app.float.normal_font_size'))
              .lineHeight($r('app.float.name_font_height'))
              .opacity(CommonConstants.FONT_OPACITY)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width(CommonConstants.FULL_LENGTH)

          Progress({
            value: this.downloadProgress,
            total: CommonConstants.PROGRESS_TOTAL
          })
            .width(CommonConstants.FULL_LENGTH)
          Row() {
            Text(CommonConstants.FILE_SIZE)
              .fontSize($r('app.float.normal_font_size'))
              .lineHeight($r('app.float.name_font_height'))
              .opacity(CommonConstants.FONT_OPACITY)
            if (this.downloadStatus === DOWNLOAD_STATUS.INITIAL) {
              this.customButton($r('app.string.button_download'), (): Promise<void> => this.start())
            } else if (this.downloadStatus === DOWNLOAD_STATUS.DOWNLOADING) {
              Row() {
                this.cancelButton()
                this.customButton($r('app.string.button_pause'), (): Promise<void> => this.pause())
              }
            } else if (this.downloadStatus === DOWNLOAD_STATUS.PAUSE) {
              Row() {
                this.cancelButton()
                this.customButton($r('app.string.button_resume'), (): Promise<void> => this.resume())
              }
            } else {
              this.customButton($r('app.string.button_finish'), (): void => this.open())
            }
          }
          .width(CommonConstants.FULL_LENGTH)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .layoutWeight(CommonConstants.CARD_CONTENT_WEIGHT)
        .height(CommonConstants.FULL_LENGTH)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width(CommonConstants.CARD_WIDTH)
      .height($r('app.float.card_height'))
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.card_border_radius'))
      .justifyContent(FlexAlign.SpaceBetween)
      .padding($r('app.float.card_padding'))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.index_background_color'))
  }
}

//wantAgent对象
let wantAgentData: WantAgent;
//WantAgentInfo对象
let wantAgentInfo: wantAgent.WantAgentInfo = {
  wants: [
    {
      deviceId: 'deviceId',
      bundleName: 'com.example.myapplication',
      abilityName: 'EntryAbility',
      action: 'action1',
      entities: ['entity1'],
      type: 'MIMETYPE',
      uri: 'key={true,true,false}',
      parameters:
      {
        mykey0: 2222,
        mykey1: [1, 2, 3],
        mykey2: '[1, 2, 3]',
        mykey3: 'ssssssssssssssssssssssssss',
        mykey4: [false, true, false],
        mykey5: ['qqqqq', 'wwwwww', 'aaaaaaaaaaaaaaaaa'],
        mykey6: true,
      }
    } as Want
  ],
  actionType: wantAgent.OperationType.START_ABILITY,
  requestCode: 0,
  wantAgentFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
};

//getWantAgent回调
function getWantAgentCallback(err: BusinessError, data: WantAgent) {
  if (err) {
    console.error(`getWantAgent failed, code: ${JSON.stringify(err.code)}, message: ${JSON.stringify(err.message)}`);
  } else {
    wantAgentData = data;
  }
}

/**
 * Obtains the resource string.
 *
 * @param resource Resource path.
 * @returns Promise instance of a string.
 */
export async function getStringByRes(resource: Resource, component: Object): Promise<string> {
  if (!resource) {
    Logger.error('getStringByRes resource is invalid');
    return '';
  }
  let string = await getContext(component).resourceManager.getStringValue(resource.id);
  return string;
}


@Extend(Button)
function buttonsStyle() {
  .constraintSize({ minWidth: $r('app.float.button_width2') })
  .height($r('app.float.button_height2'))
  .borderRadius($r('app.float.button_border_radius'))
  .fontSize($r('app.float.button_font_size'))
}