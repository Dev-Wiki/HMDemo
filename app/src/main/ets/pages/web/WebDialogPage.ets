import { ScreenUtil } from '@devwiki/base';
import { WebPage } from './WebPage';
import { TitleBar } from '@devwiki/common_ui/src/main/ets/component/TitleBar';

@CustomDialog
export struct WebPageDialog {
  @StorageLink(ScreenUtil.isPortraitKey) isPortrait: boolean = true;
  dialogController?: CustomDialogController;

  build() {
    WebPage({
      onTitleBarLeftClick: () => {
        this.dialogController?.close();
      }
    }).height(this.isPortrait ? '95%' : '90%').width(this.isPortrait ? '100%' : '50%')
  }
}

@Entry
@Component
struct WebDialogPage {

  dialogController: CustomDialogController = new CustomDialogController({
    builder: WebPageDialog(),
    alignment: DialogAlignment.BottomEnd,
    customStyle: true
  })

  build() {
    Column() {
      TitleBar({
        title: 'WebDialogPage',
        onLeftClicked: () => {
          this.getUIContext().getRouter().back()
        }
      })
      Row(){
        Button("Click").width(100).height(32).onClick(() => {
          this.dialogController.open();
        })
      }.height('100%').width('100%').justifyContent(FlexAlign.Center)
    }
  }
}