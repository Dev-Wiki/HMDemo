import { TitleBar } from '@devwiki/common_ui';
import { i18n } from '@kit.LocalizationKit';
import { Log } from '@devwiki/base';

const TAG = '[SetLanguagePage]'

@Entry
@Component
struct SetLanguagePage {
  private readonly languageGroup = "languageGroup"
  @State selectedLanguage: string = 'zh-Hans';

  aboutToAppear(): void {
    let languages:string[] = i18n.System.getSystemLanguages();
    languages.forEach((value, index) => {
      Log.info(TAG, `${index.toString()}:${value}`)
    })
  }

  build() {
    Column() {
      TitleBar({
        title: $r('app.string.set_language_title')
      });
      Row() {
        Text('简体中文');
        Radio({ group: this.languageGroup, value: 'zh-Hans' }).checked(this.selectedLanguage == 'zh-Hans')
          .onChange(isChecked => {
            if (isChecked) {
              i18n.System.setAppPreferredLanguage('zh-Hans')
              this.selectedLanguage = 'zh-Hans'
            }
          });
      }

      Row() {
        Text('英文');
        Radio({ group: this.languageGroup, value: 'en-US' }).checked(this.selectedLanguage == 'en-US')
          .onChange(isChecked => {
            if (isChecked) {
              i18n.System.setAppPreferredLanguage('en-US')
              this.selectedLanguage = 'en-US'
            }
          });
      }
    }.width('100%').height('100%')
  }
}