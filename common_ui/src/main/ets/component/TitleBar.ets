import { ComponentConst } from './ComponentConst'

export enum TitleBarMenuType{
  /**
   * 不显示
   */
  None = 0,
  /**
   * 显示Icon
   */
  Icon = 1,
  /**
   * 显示文本
   */
  Text = 2
}

@Preview
@Component
export struct TitleBar {

  @Prop title: ResourceStr;

  @Prop barHeight: number = 48;
  @Prop menuPadding: number = 8;

  @Prop leftText: ResourceStr = "";
  @Prop leftIcon: Resource = $r("app.media.ic_chevron_left");
  @Prop leftMenuType: TitleBarMenuType = TitleBarMenuType.Icon;

  @Prop rightText: ResourceStr = "";
  @Prop rightIcon: Resource = $r("app.media.ic_close");
  @Prop rightMenuType: TitleBarMenuType = TitleBarMenuType.Icon;

  @Prop titleTextAlign: TextAlign = TextAlign.Start;
  @Prop titleVisible: Visibility = Visibility.Visible;

  onLeftClicked?: Function;
  onRightClicked?: Function;

  @Styles setWidthAndHeight() {
    .height(this.barHeight).width(this.barHeight)
  }

  build() {
    RelativeContainer() {
      if (this.leftMenuType != TitleBarMenuType.None) {
        Button() {
          if (this.leftMenuType == TitleBarMenuType.Icon) {
            Image(this.leftIcon)
              .setWidthAndHeight()
              .padding(this.menuPadding)
          } else {
            Text(this.leftText)
              .textAlign(TextAlign.Center)
              .setWidthAndHeight()
          }
        }
        .setWidthAndHeight()
        .backgroundColor(0xFFFFFF)
        .type(ButtonType.Normal)
        .stateEffect(true)
        .onClick((event) => {
          this.onLeftClicked?.(event);
        })
        .alignRules({
          top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
          left: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start },
        }).id("left_menu")
      }

      if (this.titleVisible == Visibility.Visible) {
        Text(this.title)
          .textAlign(this.titleTextAlign)
          .backgroundColor(0xFFFFFF)
          .padding({
            left: this.leftMenuType != TitleBarMenuType.None ? 0 : this.menuPadding,
            right: this.rightMenuType != TitleBarMenuType.None ? 0 : this.menuPadding
          })
          .alignRules({
            top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
            left: {
              anchor: this.leftMenuType != TitleBarMenuType.None ? "left_menu" : ComponentConst.ContainerId,
              align: this.leftMenuType != TitleBarMenuType.None ? HorizontalAlign.End : HorizontalAlign.Start
            },
            right: {
              anchor: this.rightMenuType != TitleBarMenuType.None ? "right_menu" : ComponentConst.ContainerId,
              align: this.rightMenuType != TitleBarMenuType.None ? HorizontalAlign.Start : HorizontalAlign.End
            },
            bottom: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
          })
          .id("title")
      }

      if (this.rightMenuType != TitleBarMenuType.None) {
        Button() {
          if (this.rightMenuType == TitleBarMenuType.Icon) {
            Image(this.rightIcon)
              .setWidthAndHeight().padding(this.menuPadding)
          } else {
            Text(this.rightText)
              .textAlign(TextAlign.Center)
              .setWidthAndHeight()
          }
        }
        .setWidthAndHeight()
        .backgroundColor(0xFFFFFF)
        .type(ButtonType.Normal)
        .stateEffect(true)
        .onClick((event) => {
          this.onRightClicked?.(event);
        })
        .alignRules({
          top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top },
          right: { anchor: ComponentConst.ContainerId, align: HorizontalAlign.End },
        }).id("right_menu")
      }
    }
    .width('100%').height('100%').height(this.barHeight)
  }
}