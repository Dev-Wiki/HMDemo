
@Entry
@Component
struct TextPage {

  @State states: string[] = ['1', '2', '3', '4'];

  build() {
    Column(){
      Button('Change').onClick(() => {
        this.states[3] = '999'
      })
      List(){
        ForEach(this.states, (state: string, index: number) => {
          ListItem(){
            Column(){
              Text(state).width(this.getWidth(state, index))
              Divider().width('90%')
            }
          }
        })
      }.height('100%').width('100')
    }.width('100%')
  }

  getWidth(title: string, index: number): Length {
    return 0;
  }
}