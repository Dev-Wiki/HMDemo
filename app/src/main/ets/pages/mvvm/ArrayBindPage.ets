
@Entry
@Component
export struct ArrayBindPage {

  @State firstDatas: string[] = ["1"];
  @State secondDatas: string[] = ["2"]

  build() {
    Column(){

      Text(this.firstDatas[0]);
      Text(this.secondDatas[0]).margin({top: 16})
      Button("Change").margin({top: 16}).onClick(() => {
        let first = this.firstDatas;
        this.changeFirstIndex(first);
        this.changeFirstIndex(this.secondDatas);
      })
    }.width('100%').height('100%')
  }

  changeFirstIndex(datas: string[]) {
    datas[0] = '111'
  }
}