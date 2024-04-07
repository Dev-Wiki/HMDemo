import { ComponentConst, ScreenUtil, TitleBar } from '@devwiki/common_ui';
import { TitleBarMenuType } from '@devwiki/common_ui/src/main/ets/component/TitleBar';
import { router } from '@kit.ArkUI';
import { PageRouter } from './PageRouter';
import { WebPage } from './WebPage';

@CustomDialog
struct WebViewDialog {

  aboutToAppear(): void {
    ScreenUtil.getInstance().initScreenSize();
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebViewDialog({})
  });

  build() {
    WebPage().height('100%').width('50%')
  }
}

@Entry
@Component
struct Index {
  @State title: string = "Home";
  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebViewDialog(),
    alignment: DialogAlignment.CenterEnd,
    customStyle: true
  })

  onTitleBarLeftClick(_event: ClickEvent) {
    this.getUIContext().getRouter().back();
  }


  onButtonClicked() {
    this.dialogController.open();

    // router.pushUrl({
    //   // 两种方式都可以加载Page, 一个是和 resources/base/profile/main_pages.ets中的配置相同
    //   // 一个是绝对路径
    //   // url: "pages/WebPage",
    //   url: PageRouter.WebPage
    // }, router.RouterMode.Single);
  }

  build() {
    Column() {
      RelativeContainer() {
        TitleBar({
          title: this.title,
          onLeftClicked: this.onTitleBarLeftClick,
          rightMenuType: TitleBarMenuType.None
        })
          .width('100%')
          .alignRules({
            top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
            left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start }
          }).id("title_bar"); //必须要设置id 否则不显示

        Divider().alignRules({
          top: { anchor: "title_bar", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start }
        }).width('100%').id("divider") //必须要设置id 否则不显示

        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Button("WebPage").type(ButtonType.Capsule).align(Alignment.Center).height(36).width(80).onClick(() => {
              this.onButtonClicked();
            })
          }.width(36);
          Row().height(36);
          Row().width(36);
        }
        .width('100%')
        .alignRules({
          top: { anchor: "divider", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
          bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        }).id("host_web") //必须要设置id 否则不显示
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}