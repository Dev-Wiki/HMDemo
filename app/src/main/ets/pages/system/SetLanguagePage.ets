import { TitleBar } from '@devwiki/common_ui';
import { i18n } from '@kit.LocalizationKit';

@Entry
@Component
struct SetLanguagePage {

  private readonly languageGroup = "languageGroup"
  @State selectedIndex: number = 0;

  build() {
    Column() {
      TitleBar({
        title: $r('app.string.set_language_title')
      });
      Row() {
        Text('简体中文');
        Radio({group: this.languageGroup, value: '简体中文'}).checked(true).onChange(isChecked => {
          if (isChecked) {
            this.selectedIndex = 0;
          }
        });
      }
      Row() {
        Text('英文');
        Radio({group: this.languageGroup, value: '英文'}).checked(false).onChange(isChecked => {
          if (isChecked) {
            this.selectedIndex = 1;
          }
        });
      }

      Button('修改语言').onClick(() => {
        i18n.System.setAppPreferredLanguage(this.selectedIndex == 0 ? 'zh-Hans' : 'en-US')
      })
    }.width('100%').height('100%')
  }
}