
@Entry
@Component
struct LinearLayoutPage {

  columnMargin:number = 8
  columnBgColor:string = '#26c6da'
  @State columnJustifyContent: FlexAlign = FlexAlign.SpaceEvenly;
  @State columnAlignItems :HorizontalAlign = HorizontalAlign.Center;

  pageTransition() {
    // 定义页面进入时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 200 }).opacity(1)
    // 定义页面退出时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: 200 }).opacity(0)
  }

  build() {
    // Column的子元素垂直排列, 即1列N行
    Column() {
      Row() {
        Text(`Column的子元素垂直排列, 即1列N行, 当前为第1行 \n Column的margin:${this.columnMargin}`)
          .width('100%')
      }.width('80%').height(96).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceEvenly)
      .borderWidth(1)

      Column() {
        Text("当前为第2行,不同的justifyContent会影响行之间的间隔");
        Button("切换justifyContent").onClick((event: ClickEvent) => {
          if (this.columnJustifyContent < FlexAlign.SpaceEvenly) {
            this.columnJustifyContent++;
          } else {
            this.columnJustifyContent = 0;
          }
        })
      }.width('80%').height(96).alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.SpaceEvenly)
      .borderWidth(1)

      Column() {
        Text("当前为第3行, 不同的alignItems会影响在水平方向上的对其方式");
        Button("切换alignItems").onClick((event: ClickEvent) => {
          if (this.columnAlignItems < HorizontalAlign.End) {
            this.columnAlignItems++
          } else {
            this.columnAlignItems = 0;
          }
        })
      }.width('80%').height(96).alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.SpaceEvenly)
      .borderWidth(1)
    }.height('100%').width('100%').alignItems(this.columnAlignItems).justifyContent(this.columnJustifyContent)
    .backgroundColor('#26c6da')
  }
}