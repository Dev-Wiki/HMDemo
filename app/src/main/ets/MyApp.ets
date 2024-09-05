import { Context } from '@ohos.arkui.UIContext';
import { window } from '@kit.ArkUI';

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
}