import web_webview from '@ohos.web.webview';
import { WebScriptCallback, WebScriptFunction } from './WebScript';
import { picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class WebViewParam {
  webUrl: string = "";
}

@Component
export struct WebView {

  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  selectOptions?: picker.PhotoSelectOptions | picker.DocumentSelectOptions;
  viewPicker?: picker.PhotoViewPicker | picker.DocumentViewPicker;
  controller: WebViewController = new WebViewController();
  @Prop @Watch("onParamChanged")param: WebViewParam = new WebViewParam();

  onParamChanged() {
    if (this.webviewController.getUrl() && this.param.webUrl != this.webviewController.getUrl()) {
      let a = this.webviewController.getUrl();
      this.controller.loadUrl(this.param.webUrl);
    }
  }

  aboutToAppear(): void {
    this.controller.setWebviewController(this.webviewController);
  }

  build() {
    Web({ src: this.param.webUrl, controller: this.webviewController })
      .javaScriptAccess(true)// 允许使用 js
      .javaScriptProxy({
        object: this.controller,
        name: WebViewController.JsBridgeName,
        methodList: WebViewController.JsMethodName,
        controller: this.webviewController
      })
      .onPageEnd(() => { this.controller.onPageEnd(this.webviewController.getTitle()) })
      .onShowFileSelector( (event) =>{
        let uri: string[] | null = null;
        this.selectOptions = new picker.DocumentSelectOptions();
        this.viewPicker = new picker.DocumentViewPicker();
        this.viewPicker.select(this.selectOptions).then((result) => {
          uri = result;
          console.info('DocumentViewPicker.select to file succeed and uri is:' + uri);
          if (event) {
            event.result.handleFileList(uri);
          }
        }).catch((err: BusinessError) => {
          console.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
        })
        return true;
      })
      .width('100%')
      .height('100%');
  }
}

interface WebViewCallback {
  onPageEnd(title: string): void;
}


export class WebViewController implements WebScriptCallback, WebScriptFunction, WebViewCallback {

  static readonly JsBridgeName = "devwiki";
  static readonly JsMethodName = [""];

  private webviewController?: web_webview.WebviewController

  constructor() {
  }

  setWebviewController(webviewController: web_webview.WebviewController) {
    this.webviewController = webviewController;
  }

  refresh() {
    this.webviewController?.refresh();
  }

  accessBackward(): boolean {
    return this.webviewController?.accessBackward() ?? false;
  }

  backward() {
    return this.webviewController?.backward();
  }

  accessForward(): boolean {
    return this.webviewController?.accessForward() ?? false;
  }

  forward() {
    return this.webviewController?.forward();
  }

  getCurrentUrl(): string {
    return this.webviewController?.getUrl() ?? "";
  }

  getNativePageFileName(): string {
    return "";
  }

  alert(message: string): void {
    this.webviewController?.runJavaScript(`window.alert(${message})`);
  }

  loadUrl(url: string) {
    this.webviewController?.loadUrl(url);
  }

  onPageEnd(title: string) {
  }
}