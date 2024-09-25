import { pasteboard } from '@kit.BasicServicesKit';

class PasteboardUtil {

  static async copyData(data: string, type: CopyDataType) {
    try {
      if (!data) {
        return;
      }

      let mineType = pasteboard.MIMETYPE_TEXT_PLAIN;

      if (type === CopyDataType.URI) {
        mineType = pasteboard.MIMETYPE_TEXT_URI;
      } else if (type === CopyDataType.HTML) {
        mineType = pasteboard.MIMETYPE_TEXT_HTML;
      }

      const pasteData: pasteboard.PasteData = pasteboard.createData(mineType, data);
      const systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();

      await systemPasteboard.setData(pasteData);
    } catch (err) {
      console.error('Failed to set PasteData.');
    }
  }
}

export enum CopyDataType {
  TEXT,
  URI,
  HTML
}