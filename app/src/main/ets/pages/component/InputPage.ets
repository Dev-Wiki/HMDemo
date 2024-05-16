import { CommonRes, PhoneInput } from '@devwiki/common_ui/Index';

@Entry
@Component
struct InputPage {

  @Builder settingItem() {
    Button() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center
      }) {
        Text("AppAbility_label").fontSize(14)

        Row() {
          Text("hint").margin({right: CommonRes.getFloat('size_4vp')})
            .fontSize(14)

          Image(CommonRes.getImage('ic_chevron_left')).height(24).width(24);
        }
      }.width('100%')
      .padding({
        top: 16,
        bottom: 16
      })
    }.type(ButtonType.Normal).width('100%').backgroundColor(Color.Red)
  }

  build() {
    Column(){
      this.settingItem()
      Text("123")
    }.width('100%').height('100%')
  }
}