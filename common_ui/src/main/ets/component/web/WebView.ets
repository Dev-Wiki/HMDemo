import web_webview from '@ohos.web.webview';
import { WebScriptCallback, WebScriptFunction } from './WebScript';

@Component
export struct WebView {

  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  controller: WebViewController = new WebViewController();
  @Prop webUrl: string = "";

  aboutToAppear(): void {
    this.controller.setWebviewController(this.webviewController);
  }

  build() {
    Web({ src: this.webUrl, controller: this.webviewController })
      .javaScriptAccess(true)// 允许使用 js
      .javaScriptProxy({
        object: null,
        name: "",
        methodList: [],
        controller: this.webviewController
      })
      .onPageEnd(() => { this.controller.onPageEnd(this.webviewController.getTitle()) })
      .width('100%')
      .height('100%');
  }
}

interface WebViewCallback {
  onPageEnd(title: string): void;
}


export class WebViewController implements WebScriptCallback, WebScriptFunction, WebViewCallback {

  private webviewController?: web_webview.WebviewController

  constructor() {
  }

  setWebviewController(webviewController: web_webview.WebviewController) {
    this.webviewController = webviewController;
  }

  refresh() {
    this.webviewController?.refresh();
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