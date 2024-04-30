import { common, Want } from '@kit.AbilityKit';

@Component
@Entry
export struct SchemePage {



  build() {
  }

  openHttp() {
    let context = getContext(this) as common.UIAbilityContext;
    let wantInfo: Want = {
      uri: 'https://devwiki.net'
    }
    context.startAbility(wantInfo);
  }
}