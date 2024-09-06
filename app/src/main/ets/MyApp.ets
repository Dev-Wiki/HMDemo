import { Context } from '@ohos.arkui.UIContext';
import { window } from '@kit.ArkUI';
import { abilityAccessCtrl } from '@kit.AbilityKit';
import { Log } from '@devwiki/base';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = '[MyApp]'

export class MyApp {

  static appContext: Context;
  static uiContext: UIContext;
  static mainWindow: window.Window;
  static uiAbilityContext: Context;

  private constructor() {
  }

  static initAbility(uiAbilityContext: Context) {
    MyApp.uiAbilityContext = uiAbilityContext;
    MyApp.appContext = uiAbilityContext.getApplicationContext();
  }

  static initWindow(window: window.Window) {
    MyApp.mainWindow = window;
    MyApp.uiContext = window.getUIContext();
  }

  static requestBasicPermission() {
    let atManager = abilityAccessCtrl.createAtManager();
    try {
      atManager.requestPermissionsFromUser(MyApp.uiAbilityContext,
        ['ohos.permission.INTERNET'])
        .then((data) => {
          Log.i(TAG, 'requestBasicPermission, data:' + data.permissions[0])
        })
        .catch((err: BusinessError) => {
          Log.i(TAG, 'requestBasicPermission, error:' + err.message)
        })
    } catch (err) {
    }
  }
}