import { ComponentConst } from './ComponentConst'


@Preview
@Component
export struct TitleBar {

  @State barHeight: number = 48;
  @State menuPadding: number = 8;

  @State leftText: ResourceStr = "Back";
  @State leftTextVisible: Visibility = Visibility.Hidden;
  @State leftIconVisible: Visibility = Visibility.Visible;

  @State rightText: ResourceStr = "Menu";
  @State rightTextVisible: Visibility = Visibility.Hidden;
  @State rightIconVisible: Visibility = Visibility.Hidden;

  @State title: ResourceStr = "Title";
  @State titleTextAlign: TextAlign = TextAlign.Start;
  @State titleVisible: Visibility = Visibility.Visible;

  onLeftClicked?: Function;
  onRightClicked?: Function;

  build() {
    Row() {
      RelativeContainer() {
        Button() {
          Stack() {
            Text(this.leftText).textAlign(TextAlign.Center)
              .width(this.barHeight).height(this.barHeight).textAlign(TextAlign.Center)
              .visibility(this.leftTextVisible)
            Image($r("app.media.ic_chevron_left"))
              .width(this.barHeight).height(this.barHeight).padding(this.menuPadding)
              .visibility(this.leftIconVisible)
          }
        }.backgroundColor(0xFFFFFF).type(ButtonType.Normal).stateEffect(true)
        .onClick((event) => {
          this.onLeftClicked?.(event);
        }).alignRules({
          top: {anchor: ComponentConst.ContainerId, align: VerticalAlign.Top},
          left: {anchor: ComponentConst.ContainerId, align: HorizontalAlign.Start},
          bottom: {anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        })
        .id("left_menu")

        Text(this.title).visibility(this.titleVisible).textAlign(this.titleTextAlign).margin({left: this.menuPadding})
          .alignRules({
            top: { anchor: ComponentConst.ContainerId, align: VerticalAlign.Top},
            left: { anchor: "left_menu", align: HorizontalAlign.End},
            right: { anchor: "right_menu", align: HorizontalAlign.Start},
            bottom: {anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
          }).id("center_row")

        Stack(){
          Button() {
            Image($r("app.media.ic_close"))
              .width(this.barHeight).height(this.barHeight)
              .padding(this.menuPadding)
          }.backgroundColor(0xFFFFFF).type(ButtonType.Normal).stateEffect(true).visibility(this.rightIconVisible)
          .onClick((event) => {
            this.onRightClicked?.(event);
          });

          Button() {
            Text(this.rightText).textAlign(TextAlign.Center)
              .width(this.barHeight).height(this.barHeight).textAlign(TextAlign.Center)
          }.backgroundColor(0xFFFFFF).type(ButtonType.Normal).stateEffect(true).visibility(this.rightTextVisible)
          .onClick((event) => {
            this.onRightClicked?.(event);
          });
        }.alignRules({
          top: {anchor: ComponentConst.ContainerId, align: VerticalAlign.Top},
          right: {anchor: ComponentConst.ContainerId, align: HorizontalAlign.End},
          bottom: {anchor: ComponentConst.ContainerId, align: VerticalAlign.Bottom }
        })
        .id("right_menu")
      }
      .width('100%').height('100%')
    }.height(this.barHeight)
  }
}