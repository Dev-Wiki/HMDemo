import { CalculateAdaptor } from 'libhmcalculate.so'
import { CalculateInfo } from './CalculateInfo'

export class Calculator {

  private adaptor!:CalculateAdaptor;

  constructor() {
    this.adaptor = new CalculateAdaptor();
  }

  add(a:number, b: number): number {
    return this.adaptor.add(a, b);
  }

  getInfo(): CalculateInfo {
    return this.adaptor.getInfo() as CalculateInfo;
  }

}