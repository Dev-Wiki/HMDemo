
@Entry
@Component
struct LinearLayoutPage {

  @State space: number = 10;

  build() {
    Column({ space: '5' }) {
      Text(`space:${this.space}`)
      Row({ space: this.space}){
        Column().height('100%').width('25%').backgroundColor("#ff5577")
        Column().height('100%').width('25%').backgroundColor("#ff5577")
        Column().height('100%').width('20%').backgroundColor("#ff5577")
        Column().height('100%').width('20%').backgroundColor("#ff5577")
      }.width('90%').height('10%').backgroundColor("#11ff4455")
      Row().width('90%').height('10%').backgroundColor("#ff4455")
      Row().width('90%').height('10%').backgroundColor("#ff4455")
      Row().width('90%').height('10%').backgroundColor("#ff4455")
      Row().width('90%').height('10%').backgroundColor("#ff4455")
    }.width('100%')
  }
}