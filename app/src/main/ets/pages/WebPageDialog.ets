import { ScreenUtil } from '@devwiki/common_ui/Index';
import { WebPage } from './WebPage';

@CustomDialog
export struct WebPageDialog {

  @StorageLink(ScreenUtil.isPortraitKey)isPortrait: boolean = true;
  dialogController: CustomDialogController;

  build() {
    WebPage({onTitleBarLeftClick: ()=> {
      this.dialogController.close();
    }}).height(this.isPortrait ? '95%' : '90%').width(this.isPortrait ? '100%' : '50%')
  }
}