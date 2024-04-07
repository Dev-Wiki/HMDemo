
@Entry
@Component
struct LinearLayoutPage {

  @State space: number = 10;

  build() {
    Column({ space: this.space }) {
      Text(`space:${this.space}`)
      Row().width('90%')
      Row().width('90%')
      Row().width('90%')
    }
  }
}