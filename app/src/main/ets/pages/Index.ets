import { TitleBar } from '@devwiki/common_ui/src/main/ets/component/TitleBar';
import { ComposeTitleBar } from '@ohos.arkui.advanced.ComposeTitleBar';
import { EditableTitleBar } from '@ohos.arkui.advanced.EditableTitleBar';
import { SelectTitleBar } from '@ohos.arkui.advanced.SelectTitleBar';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  onLeftClicked(event: ClickEvent) {
    this.message = "TitleBar LeftClicked";
  }

  build() {
    Column() {
      TitleBar({onLeftClicked: this.onLeftClicked}).height(48);
      Divider();

      Text(this.message);
    }
    .height('100%')
  }
}