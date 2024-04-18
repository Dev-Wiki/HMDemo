import { TitleBar } from '@devwiki/common_ui/Index';
import picker from '@ohos.file.picker';
import { BusinessError } from '@kit.BasicServicesKit';
import fs, { ReadOptions } from '@ohos.file.fs';
import buffer from '@ohos.buffer';

@Entry
@Component
struct PhotoPage {

  build() {
    Column() {
      TitleBar({
        title: "PhotoPage",
        onLeftClicked: ()=> {
          this.getUIContext().getRouter().back();
      }}).width('100%')
      Divider();
      Button("Open").onClick(() =>{

      }).margin(5);

    }.width('100%').height('100%')
  }

  openPhotoSelector() {
    let selectOptions = new picker.PhotoSelectOptions();
    selectOptions.maxSelectNumber = 1;
    let viewPicker = new picker.PhotoViewPicker()
    viewPicker.select(selectOptions).then((result) => {
      let uri = result.photoUris;
      let file = fs.openSync(uri[0], fs.OpenMode.READ_ONLY);
      // 打开文件流
      let inputStream = fs.createStreamSync(uri[0], 'r+');
      let outputStream = buffer.alloc(fs.statSync(uri[0]).size);
      // 以流的形式读取源文件内容并写入目的文件
      let bufSize = 4096;
      let readSize = 0;
      let buf = new ArrayBuffer(bufSize);
      let readOptions: ReadOptions = {
        offset: readSize,
        length: bufSize
      };
      new String(buf);
      let readLen = inputStream.readSync(buf, readOptions);
      readSize += readLen;
      while (readLen > 0) {
        for (let index = 0; index < readSize; index++) {
          outputStream[readSize] = buf.slice(index);
        }
        readOptions.offset = readSize;
        readLen = inputStream.readSync(buf, readOptions);
        readSize += readLen;
      }
      // 关闭文件流
      inputStream.closeSync();

      console.info('PhotoViewPicker.select to file succeed and uri is:' + uri);
    }).catch((err: BusinessError) => {
      console.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    })
  }
}