import { CommonRes } from '@devwiki/common_ui/Index';
import { PageName } from '../../utils/PageRouter';
import { curves } from '@kit.ArkUI';

@Entry({ routeName: PageName.loadingPage })
@Component
struct LoadingPage {
  @State animate: boolean = false;
  @State rotateValue: number = 0;

  @Prop @Watch('onVisibleChanged')visible: boolean = false;
  onVisibleChanged() {
    if (this.visible) {
      this.animate = true;
      // 组件一的rotate属性发生变化，所以会给组件一添加rotate旋转动画
      this.rotateValue = this.animate ? 360 : 0;
    }else {
      this.animate = false;
    }
  }

  build() {
    Column() {

      Image(CommonRes.getImage('ic_loading'))
        .rotate({ angle: this.rotateValue })
        .width(32).height(32).fillColor('#2196F3')
        .animation({
          curve: curves.initCurve(Curve.Linear),
          playMode: PlayMode.Normal,
          iterations: -1,
          duration: 1000
        }).visibility(this.visible ? Visibility.Visible : Visibility.None)

      Button('change').width('60%').height(36).onClick(() =>{
        this.visible = !this.visible;
      }).margin({top: 24})
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}