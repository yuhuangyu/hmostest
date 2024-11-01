import { reminderAgentManager } from '@kit.BackgroundTasksKit';
import { CommonConstants } from '../constants/CommonConstants';
import { common } from '@kit.AbilityKit';
import { ReminderItem } from '../../viewmodel/ReminderItem';

// ...

export class ReminderService {

  private context = getContext(this) as common.UIAbilityContext;

  public addReminder(alarmItem: ReminderItem, callback?: (reminderId: number) => void) {
    let reminder = this.initReminder(alarmItem);
    reminderAgentManager.publishReminder(reminder, (err, reminderId) => {
      if (callback != null) {
        callback(reminderId);
      }
    });
  }

  public deleteReminder(reminderId: number) {
    reminderAgentManager.cancelReminder(reminderId);
  }

  private initReminder(item: ReminderItem): reminderAgentManager.ReminderRequestAlarm {

    let bundleName = this.context.abilityInfo.bundleName;
    let abilityName = this.context.abilityInfo.name;

    return {
      reminderType: item.remindType,
      hour: item.hour,
      minute: item.minute,
      daysOfWeek: item.repeatDays,
      title: item.name,
      ringDuration: item.duration * CommonConstants.DEFAULT_TOTAL_MINUTE,
      snoozeTimes: item.intervalTimes,
      timeInterval: item.intervalMinute * CommonConstants.DEFAULT_TOTAL_MINUTE,
      actionButton: [
        {
          title: '关闭',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
      // ...
      ],
      wantAgent: {
        pkgName: bundleName,
        abilityName: abilityName
      },
      notificationId: item.notificationId,
      // ...
    }
  }

}