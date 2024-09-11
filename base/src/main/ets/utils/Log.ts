
import hilog from '@ohos.hilog';

let domain: number = 0xFF00;
let prefix: string = 'HMDemo';
let format: string = `%{public}s, %{public}s`;

export class Log {

  static debug(...args: string[]) {
    hilog.debug(domain, prefix, format, args);
  }

  static info(...args: string[]) {
    hilog.info(domain, prefix, format, args);
  }

  static warn(...args: string[]) {
    hilog.warn(domain, prefix, format, args);
  }

  static error(...args: string[]) {
    hilog.error(domain, prefix, format, args);
  }

  static fatal(...args: string[]) {
    hilog.fatal(domain,prefix, format, args);
  }

  static isLoggable(level: number) {
    hilog.isLoggable(domain, prefix, level);
  }
}