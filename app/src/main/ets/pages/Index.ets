import { ComponentConst, TitleBar } from '@devwiki/common_ui';
import { TitleBarMenuType } from '@devwiki/common_ui/src/main/ets/component/TitleBar';
import { router } from '@kit.ArkUI';
import { PageRouter } from './PageRouter';

@Entry
@Component
struct Index {
  @State title: string = "Home";

  onTitleBarLeftClick(_event: ClickEvent) {
    this.getUIContext().getRouter().back();
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
          }).id("title_bar");

        Divider().alignRules({
          top: { anchor: "title_bar", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start }
        }).width('100%').id("divider")

        Column() {
          Button("WebPage").align(Alignment.Center).height(36).width(80).onClick(() => {
            router.pushUrl({
              // 两种方式都可以加载Page, 一个是和 resources/base/profile/main_pages.ets中的配置相同
              // 一个是绝对路径
              // url: "pages/WebPage",
              url: PageRouter.WebPage
            }, router.RouterMode.Single);
          })
        }
        .width('100%')
        .alignRules({
          top: { anchor: "divider", align: VerticalAlign.Bottom },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
          bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        }).id("host_web")
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}