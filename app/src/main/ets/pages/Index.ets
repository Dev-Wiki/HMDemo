import { WebView, ComponentConst,  CommonRes, TitleBar, WebViewController } from '@devwiki/common_ui';

@Entry
@Component
struct Index {

  @State viewModel: IndexViewModel = new IndexViewModel();
  private webViewController?: IndexWebViewController;

  aboutToAppear(): void {
    this.webViewController = new IndexWebViewController(this.viewModel);
  }

  onTitleBarLeftClick(event: ClickEvent) {
    this.getUIContext().getRouter().back();
  }

  onTitleBarRightClick(event: ClickEvent) {
    this.webViewController?.refresh();
  }

  build() {
    Column() {
      RelativeContainer() {
        TitleBar({
          title: this.viewModel.pageTitle,
          onLeftClicked: this.onTitleBarLeftClick,
          rightIcon: CommonRes.getIconRefresh(),
          // 必须这么写 onTitleBarRightClick内部的代码才执行,
          // 直接 onRightClicked: this.onTitleBarRightClick 这么写, 代码不执行
          onRightClicked: (event: ClickEvent) => { this.onTitleBarRightClick(event)},
        })
          .width('100%')
          .alignRules({
            top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
            left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start }
          }).id("title_bar");

        Divider().alignRules({
          top: { anchor: "title_bar", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start }
        }).width('100%').id("divider")

        WebView({ webUrl: this.viewModel?.webUrl, controller: this.webViewController }).width('100%')
          .alignRules({
            top: { anchor: "divider", align: VerticalAlign.Bottom },
            left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
            bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
          }).id("host_web")
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}

class IndexWebViewController extends WebViewController {
  private viewModel: IndexViewModel;

  constructor(viewModel: IndexViewModel) {
    super()
    this.viewModel = viewModel;
  }

  onPageEnd(title: string): void {
    this.viewModel.pageTitle = title;
  }

}

class IndexViewModel {
  webUrl: string = "https://devwiki.net";
  pageTitle: ResourceStr = "";

  constructor() {
  }

  onTitleChanged(title: string) {
    this.pageTitle = title;
  }
}