import window from '@ohos.window';
import mediaquery from '@ohos.mediaquery';

export class ScreenUtil {
  // TODO: 工具待抽离， key统一定义
  static readonly isPortraitKey: string = "xy_screen_is_portrait";
  private static instance: ScreenUtil;
  public width: number = 0
  public height: number = 0
  public statusBarHeight: number = 0
  public bottomSafeHeight: number = 0
  public contentHeight: number = 0;

  public layoutWidth: number = 0
  public layoutHeight: number = 0


  private portraitListener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: portrait)');

  public static getInstance(): ScreenUtil {
    if (!ScreenUtil.instance) {
      ScreenUtil.instance = new ScreenUtil();
    }
    return ScreenUtil.instance;
  }

  initScreenSize(): void {
    this.portraitListener.on('change', (result)=> {
      AppStorage.setOrCreate(ScreenUtil.isPortraitKey, result.matches)
    })
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR; // 以导航条避让为例
        let avoidArea = windowClass.getWindowAvoidArea(type);
        this.bottomSafeHeight = px2vp(avoidArea.bottomRect.height); // 获取到导航条区域的高度
        type = window.AvoidAreaType.TYPE_SYSTEM;
        avoidArea = windowClass.getWindowAvoidArea(type);
        this.statusBarHeight = px2vp(avoidArea.topRect.height);
        this.width = px2vp(windowClass.getWindowProperties().windowRect.width);
        this.height = px2vp(windowClass.getWindowProperties().windowRect.height);
        this.layoutWidth = this.width;
        this.layoutHeight = this.height - this.statusBarHeight - this.bottomSafeHeight;
      })
      .catch((error: Error) => {
      })
  }

  setPreferredOrientation(orientation: window.Orientation): void {
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        windowClass.setPreferredOrientation(orientation);
      })
      .catch((error: Error) => {
      })
  }

  setPreferredOrientationCallBack(orientation: window.Orientation, callback: ()=>void): void{
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        windowClass.setPreferredOrientation(orientation,callback);
        AppStorage.setOrCreate(ScreenUtil.isPortraitKey, orientation == window.Orientation.PORTRAIT || orientation == window.Orientation.PORTRAIT_INVERTED);
      })
      .catch((error: Error) => {
      })
  }

  setWindowLayoutFullScreen(isLayoutFullScreen: boolean): void {
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        windowClass.setWindowLayoutFullScreen(isLayoutFullScreen);
        windowClass.setSpecificSystemBarEnabled('status', !isLayoutFullScreen);
      })
      .catch((error: Error) => {
      })
  }

  setWindowSystemBarProperties(systemBarProperties: window.SystemBarProperties): void {
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        windowClass.setWindowSystemBarProperties(systemBarProperties, (err) => {
          if (err.code) {
            console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in setting the system bar properties.');
        });
      })
      .catch((error: Error) => {
      })
  }

  setWindowSystemBarEnable(names:Array<'status' | 'navigation'>){
    window.getLastWindow(getContext(this))
      .then((windowClass: window.Window) => {
        windowClass.setWindowSystemBarEnable(names, (err) => {
          if (err.code) {
            console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in setting the system bar properties.');
        });
      })
      .catch((error: Error) => {
      })
  }
}