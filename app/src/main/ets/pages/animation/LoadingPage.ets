import { CommonRes } from '@devwiki/common_ui/Index';
import { PageName } from '../../utils/PageRouter';
import { curves } from '@kit.ArkUI';

@Entry({ routeName: PageName.loadingPage })
@Component
export struct LoadingPage {
  @State animate: boolean = false;
  // 第一步: 声明相关状态变量
  @State rotateValue: number = 0; // 组件一旋转角度

  build() {
    Column() {

      Image(CommonRes.getImage('ic_loading'))
        .rotate({ angle: this.rotateValue })
        .width(32)
        .height(32)
        .fillColor('#2196F3')
        .animation({
          curve: curves.initCurve(Curve.Linear),
          playMode: PlayMode.Normal,
          iterations: -1,
        })
        .onAppear(() => {
          this.animate = !this.animate;
          // 组件一的rotate属性发生变化，所以会给组件一添加rotate旋转动画
          this.rotateValue = this.animate ? 360 : 0;
        })
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}