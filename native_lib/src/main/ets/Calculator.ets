import { CalculateAdapter } from 'native_lib.so'
import { CalculateInfo } from './CalculateDefine'

export class Calculator {

  private adaptor!:CalculateAdapter;

  constructor() {
    this.adaptor = new CalculateAdapter();
  }

  add(a:number, b: number): number {
    return this.adaptor.add(a, b);
  }

  getInfo(): CalculateInfo {
    return this.adaptor.getInfo() as CalculateInfo;
  }

}