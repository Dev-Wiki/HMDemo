import { TitleBar } from '@devwiki/common_ui/Index';
import { common, Want } from '@kit.AbilityKit';

@Component
@Entry
struct SchemePage {
  build() {
    Column() {
      TitleBar({
        title: 'SchemePage',
        onLeftClicked: () => {
          this.getUIContext().getRouter().back()
        }
      })

      Button("OpenApp").width(120).height(36).onClick(() => {
        this.openScheme('alipays://platformapi/startapp?appId=20000001')
      }).margin({ top: 48 })

      Button("OpenStore").width(120).height(36).onClick(() => {
        this.openScheme('store://appgallery.huawei.com/app/detail?id=com.alipay.mobile.client')
      }).margin({ top: 48 })
    }
  }

  openScheme(uri: string) {
    let context = getContext(this) as common.UIAbilityContext;
    let wantInfo: Want = {
      // action: 'ohos.want.action.viewData',
      // entities: ['entity.system.browsable'],
      uri: uri
    }
    context.startAbility(wantInfo);
  }
}