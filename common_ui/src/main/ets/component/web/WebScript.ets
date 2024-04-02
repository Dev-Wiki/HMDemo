
/**
 * H5 调用 native的函数
 */
export interface WebScriptCallback {
  getCount(): number;
}

/**
 * native 调用 H5的函数
 */
export interface WebScriptFunction {

  alert(message: string): void;
}