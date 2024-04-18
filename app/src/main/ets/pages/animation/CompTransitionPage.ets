import { CommonRes, TitleBar, TitleBarMenuType } from '@devwiki/common_ui'
import { curves, router } from '@kit.ArkUI';


@Entry
@Component
struct CompTransitionPage {
  @State isShow: boolean = true;
  @State headHeight: string = '';
  @State rightIcon: Resource = CommonRes.getIconEyeOff();

  build() {
    Column({ space: 8 }) {
      TitleBar({
        title: "CompTransitionPage",
        titleTextAlign: TextAlign.Center,
        onLeftClicked: () => {
          router.back()
        },
        rightMenuType: TitleBarMenuType.Icon,
        rightIcon: this.rightIcon,
        onRightClicked: () => {
          this.isShow = !this.isShow;
          if (this.isShow) {
            this.headHeight = ''
            this.rightIcon = CommonRes.getIconEyeOff()
          } else {
            this.headHeight = '0%'
            this.rightIcon = CommonRes.getIconEyeOn()
          }
        }
      });
      Column({ space: 8 }) {
        Text("第1行");
        Text("第2行");
        Text("第3行");
        Text("第4行");
      }.width('100%').height(this.headHeight).backgroundColor('#8bc34a')
      .animation({ curve: curves.springMotion() })

      Column().height('100%').width('100%').borderWidth(1).borderColor('#ff5722')
    }.height('100%').width('100%')
  }
}