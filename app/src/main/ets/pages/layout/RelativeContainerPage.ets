import { ComponentConst } from '@devwiki/common_ui/Index'


@Entry
@Component
struct RelativeContainerPage {

  build() {
    RelativeContainer() {
      Button('1111')
        .alignRules({
          top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
          bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        }).id('left_menu0')

      Button(){
        Text("2222").height(64)
      }
        .alignRules({
          top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
          right: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.End },
          bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        }).id('right_menu0')
    }.height(64).width('100%').backgroundColor(Color.Red)
  }
}