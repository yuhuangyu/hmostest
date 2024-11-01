
// PreferenceModel.ets
import { preferences } from '@kit.ArkData';
import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';

let context = getContext(this);
let preference: preferences.Preferences;
let preferenceTemp: preferences.Preferences;

class PreferenceModel {

  // 调用getPreferences方法读取指定首选项持久化文件，将数据加载到Preferences实例，用于数据操作
  async getPreferencesFromStorage() {
    try {
      preference = await preferences.getPreferences(context, CommonConstants.PREFERENCES_NAME);
    } catch (err) {
      Logger.error(CommonConstants.TAG, `Failed to get preferences, Cause: ${err}`);
    }
  }

  /**
   * Deletes the specified Preferences persistence file from memory and removes the Preferences instance.
   * 删除数据文件
   */
  async deletePreferences() {
    try {
      await preferences.deletePreferences(context, CommonConstants.PREFERENCES_NAME);
    } catch(err) {
      Logger.error(CommonConstants.TAG, `Failed to delete preferences, Cause: ${err}`);
    };
    preference = preferenceTemp;
    // CommonUtils.showToast($r('app.string.delete_success_msg'));
  }

  // PreferenceModel.ets
  // async putPreference(fruit: Fruit) {
  //   if (!preference) {
  //     await this.getPreferencesFromStorage();
  //   }
  //   try {
  //     // 将用户输入的水果名称和水果数量数据，保存到缓存的Preference实例中
  //     await preference.put(CommonConstants.KEY_NAME, JSON.stringify(fruit));
  //   } catch (err) {
  //     Logger.error(CommonConstants.TAG, `Failed to put value, Cause: ${err}`);
  //   }
  //   // 将Preference实例存储到首选项持久化文件中
  //   await preference.flush();
  // }

  // PreferenceModel.ets
  // async getPreference() {
  //   let fruit = '';
  //   // ...
  //   try {
  //     // fruit = (await preference.get(CommonConstants.KEY_NAME, '')).toString();
  //   } catch (err) {
  //     Logger.error(CommonConstants.TAG, `Failed to get value, Cause: ${err}`);
  //   }
  // }

}

export default new PreferenceModel();