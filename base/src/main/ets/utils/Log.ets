
import hilog from '@ohos.hilog';

let domain: number = 0xFF00;
let prefix: string = 'HM4Demo';
let format: string = `%{public}s`;

export class Log {

  static d(...args: string[]) {
    hilog.debug(domain, prefix, format, args);
  }

  static i(...args: string[]) {
    hilog.info(domain, prefix, format, args);
  }

  static w(...args: string[]) {
    hilog.warn(domain, prefix, format, args);
  }

  static e(...args: string[]) {
    hilog.error(domain, prefix, format, args);
  }

  static f(...args: string[]) {
    hilog.fatal(domain,prefix, format, args);
  }

  static isLoggable(level: number) {
    hilog.isLoggable(domain, prefix, level);
  }
}