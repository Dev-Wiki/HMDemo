import { util } from '@kit.ArkTS';

export class Res {

  static getRawFileContent(name: string): string {
    let content = getContext().resourceManager.getRawFileContentSync(name);
    let textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM : true
    }
    let decodeWithStreamOptions: util.DecodeWithStreamOptions = {
      stream: true
    }
    let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
    let retStr = textDecoder.decodeWithStream( content , decodeWithStreamOptions);
    return retStr;
  }
}