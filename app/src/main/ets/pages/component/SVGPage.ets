import { CommonRes } from '@devwiki/common_ui/Index'

@Entry
@Component
export struct SVGPage {
  build() {
    Column() {
      Text().width(96).height(96).backgroundColor($r('app.media.ic_eye_off'))
        .linearGradient({
          angle: 90,
          colors: [[0xff0000, 0.0], [0x0000ff, 0.3], [0xffff00, 1.0]],
          repeating: true
        })
    }.height('100%').justifyContent(FlexAlign.Center)
  }
}