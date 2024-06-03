import { Toast } from '@devwiki/common_ui/'

@Observed
class ToastViewMode {

  showToast?: (msg: ResourceStr) => void;

  showHint(msg: ResourceStr) {
    this.showToast?.(msg);
  }
}

@Entry
@Component
export struct ToastPage {

  @Provide toastVM: ToastViewMode = new ToastViewMode();

  aboutToAppear(): void {
    this.toastVM.showToast = (msg: ResourceStr) => {
      Toast.showToast(msg, true);
    }
  }

  build() {

    Column(){
      Button("ShowDefault").width('80%').height(36).onClick(() =>{
        Toast.showToast("Test Default")
      })

      Button("ShowTopmost").width('80%').height(36).onClick(() =>{
        Toast.showToast("Test Topmost", true)
      }).margin({ top: 16 })

      Button("VM Show").width('80%').height(36).onClick(() =>{
        this.toastVM.showHint("test vm Show")
      }).margin({ top: 16 })
    }.height('100%').width('100%').justifyContent(FlexAlign.Center)
  }
}