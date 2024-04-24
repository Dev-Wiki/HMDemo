import { Calculate } from 'libnatvie_lib.so';

export class Calculator {

    static add(a: number, b:number) : number {
        return Calculate.add(a, b);
    }
}