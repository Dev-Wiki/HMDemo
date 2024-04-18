import { ComponentConst, ScreenUtil, TitleBar } from '@devwiki/common_ui';
import web_webview from '@ohos.web.webview';
import { TitleBarMenuType } from '@devwiki/common_ui';
import { WebPage } from './web/WebPage';
import { router, window } from '@kit.ArkUI';
import { WebPageDialog } from './web/WebPageDialog'
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@ohos.base';
import { Log } from '../utils/Log';

@CustomDialog
struct WebViewDialog {
  webUrl: string = "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/password"
  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  dialogController: CustomDialogController;
  @StorageLink(ScreenUtil.isPortraitKey)isPortrait: boolean = true;

  build() {
    Row() {
      Web({ src: this.webUrl, controller: this.webviewController })
        .javaScriptAccess(true)// 允许使用 js
        .width('100%')
        .height('100%');
    }.height(this.isPortrait ? '95%' : '90%').width(this.isPortrait ? '100%' : '50%')
  }
}

@Entry
@Component
struct Index {

  @State title: string = "Home";

  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebViewDialog(),
    alignment: DialogAlignment.BottomEnd,
    customStyle: true
  })

  aboutToAppear(): void {
    ScreenUtil.getInstance().initScreenSize();
  }

  onPageShow(): void {
    ScreenUtil.getInstance().setPreferredOrientation(window.Orientation.AUTO_ROTATION);
  }

  /**
   * 页面的进入 退出动画 router时生效
   */
  pageTransition() {
    // 定义页面进入时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 100 }).opacity(1)
    // 定义页面退出时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: 100 }).opacity(0)
  }

  /**
   * 拦截手势侧滑返回和标题栏的返回按钮, 增加弹窗提醒。
   * @returns
   */
  onBackPress(): boolean | void {
    // 弹出自定义的询问框
    promptAction.showDialog({
      message: '确定要退出吗？',
      buttons: [
        {
          text: '取消',
          color: '#FF0000'
        },
        {
          text: '确认',
          color: '#0099FF'
        }
      ]
    }).then((result: promptAction.ShowDialogSuccessResponse) => {
      if (result.index === 0) {
        // 用户点击了“取消”按钮
        Log.i('User canceled the operation.');
      } else if (result.index === 1) {
        // 用户点击了“确认”按钮
        Log.i('User confirmed the operation.');
        // 调用router.back()方法，返回上一个页面
        router.back();
      }
    }).catch((err: Error) => {
      let message = (err as BusinessError).message
      let code = (err as BusinessError).code
      Log.i(`Invoke showDialog failed, code is ${code}, message is ${message}`);
    })
    return true;
  }

  build() {
    Column() {
      TitleBar({
        title: this.title,
        onLeftClicked: ()=> { this.onBackPress() },
        rightMenuType: TitleBarMenuType.None
      }).width('100%')

      Column() {
        Row() {
          Button("WebDialog").width(100).height('100%').type(ButtonType.Normal)
            .onClick(() => { this.dialogController.open() });

          Button("Layout").width(100).height('100%').type(ButtonType.Normal).onClick(() =>{
            router.pushUrl({url: "pages/layout/LinearLayoutPage"});
          });

          Button("Animation").width(100).height('100%').type(ButtonType.Normal).onClick(() =>{
            router.pushUrl({url: "pages/animation/CompTransitionPage"});
          });

        }.width('100%').height(48).justifyContent(FlexAlign.SpaceEvenly)
      }.justifyContent(FlexAlign.Center).width('100%')
    }.width('100%').height('100%')
  }
}