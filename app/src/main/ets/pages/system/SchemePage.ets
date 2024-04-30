import { TitleBar } from '@devwiki/common_ui/Index';
import { common, Want } from '@kit.AbilityKit';

@Component
@Entry
export struct SchemePage {
  build() {
    Column() {
      TitleBar({
        title: 'SchemePage',
        onLeftClicked: () => {
          this.getUIContext().getRouter().back()
        }
      })

      Button("Open").width(120).height(36).onClick(() => {
        this.openScheme()
      }).margin({ top: 48 })
    }
  }

  openScheme() {
    let context = getContext(this) as common.UIAbilityContext;
    let wantInfo: Want = {
      uri: 'https://devwiki.net'
    }
    context.startAbility(wantInfo);
  }
}