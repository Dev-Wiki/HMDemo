import { PageName } from '../PageName';

@Component
@Entry({routeName: PageName.ScaleRotatePage})
struct ScaleRotatePage {

  @State orderId:string = ''
  @State rootJustifyContent: FlexAlign = FlexAlign.Start

  @State showQRAnimation: boolean= false
  @State qrColumnHeight: Length = ''
  @State qrJustifyContent: FlexAlign = FlexAlign.Start

  @State showBarcodeAnimation : boolean = false;
  @State barcodeHeight: Length = ''
  @State barcodeAngle: number = 0

  @Builder
  ScanBarCodeDialog(){

  }

  private ScanBarCodeDialogController: CustomDialogController = new CustomDialogController({
    builder: this.ScanBarCodeDialog,
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true,
    openAnimation: {

    }
  })

  build() {

    Column(){
      Text('Title')

      Column(){
        Image($r('app.media.ic_eye_off')).width(200).height(200).onClick(() =>{

        })
        Text('Order Id:' + this.orderId).visibility(this.showQRAnimation ? Visibility.Visible : Visibility.None)
      }.width('100%').visibility(this.showBarcodeAnimation ? Visibility.None : Visibility.Visible)
      .animation({
        duration: 1000
      })

      Text('Order Id:' + this.orderId).visibility(this.showQRAnimation || this.showBarcodeAnimation ? Visibility.None : Visibility.Visible)

      Column(){

        Text('Order Id:' + this.orderId).visibility(this.showBarcodeAnimation ? Visibility.Visible : Visibility.None)

        Image($r('app.media.ic_eye_off')).width(400).height(100).onClick(() =>{
        })
      }.visibility(this.showQRAnimation ? Visibility.None : Visibility.Visible)
      .rotate({ centerX: '50%', centerY: '50%', angle: this.barcodeAngle})
      .animation({
        duration: 1000
      })


    }.width('100%').height('100%').alignItems(HorizontalAlign.Center).justifyContent(this.rootJustifyContent)
  }


}