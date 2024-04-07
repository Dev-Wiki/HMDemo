import { ComponentConst, ScreenUtil, TitleBar } from '@devwiki/common_ui';
import { TitleBarMenuType } from '@devwiki/common_ui/src/main/ets/component/TitleBar';
import { WebPage } from './WebPage';
import { window } from '@kit.ArkUI';

@CustomDialog
struct WebViewDialog {

  showHeight: Length = '50%';
  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebViewDialog({})
  });

  build() {
    WebPage({onTitleBarLeftClick: ()=> {
      this.dialogController.close();
    }}).height(this.showHeight).width('100%')
  }
}

@Entry
@Component
struct Index {

  @State title: string = "Home";
  @StorageLink(ScreenUtil.isPortraitKey)isPortrait: boolean = true;

  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebViewDialog({showHeight: this.isPortrait ? '95%' : '50%'}),
    alignment: DialogAlignment.BottomEnd,
    customStyle: true
  })

  aboutToAppear(): void {
    ScreenUtil.getInstance().initScreenSize();
  }

  onPageShow(): void {
    ScreenUtil.getInstance().setPreferredOrientation(window.Orientation.AUTO_ROTATION_PORTRAIT);
  }

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

        Grid() {
          GridItem() {
            Button("Layout").type(ButtonType.Capsule).height(32).width(80);
          }.rowStart(0).rowEnd(0).columnStart(0).columnEnd(0)

          GridItem() {
            Button("WebPage").type(ButtonType.Capsule).height(32).width(80)
              .onClick(() => { this.dialogController.open() });
          }.rowStart(0).rowEnd(0).columnStart(1).columnEnd(1)

          GridItem() {
            Button("3").type(ButtonType.Capsule).height(32).width(80);
          }.rowStart(0).rowEnd(0).columnStart(2).columnEnd(2)

          GridItem() {
            Button("4").type(ButtonType.Capsule).height(32).width(80);
          }.rowStart(0).rowEnd(0).columnStart(3).columnEnd(3)

          GridItem() {
            Button("1").type(ButtonType.Capsule).height(32).width(80);
          }.rowStart(1).rowEnd(1).columnStart(0).columnEnd(0)
        }
        .width('100%').backgroundColor('#FF005566')
        .columnsTemplate('1fr 1fr 1fr 1fr').columnsGap(8)
        .rowsTemplate('repeat(auto-fill, 36)').rowsGap(8)
        .alignRules({
          top: { anchor: "divider", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
          bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        }).id("host_web") //必须要设置id 否则不显示
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}