
export interface EmitterItem {
  key: string
  listener: Function
}

type EmitterAllType = string | object | boolean | number | Object | Number | BigInt;

export class Emitter {
  private static instance: Emitter;
  private static events: Map<string, EmitterItem[]> = new Map
  private static viscosityData: Map<string, EmitterAllType[]> = new Map

  public static getInstance(): Emitter {
    if (!Emitter.instance) {
      Emitter.instance = new Emitter();
    }

    return Emitter.instance;
  }

  /**
   * 添加监听
   * @param key
   * @param listener
   * @returns
   */
  public on(key: string, listener: Function): EmitterItem {
    let item: EmitterItem = {key: key, listener: listener};
    if (typeof listener !== "function") {
      throw new TypeError('the listener not a function')
    }
    let items: EmitterItem[] | undefined = Emitter.events.get(key);
    if (!items) {
      items = []
    }
    items.push(item)
    Emitter.events.set(key, items)
    if (Emitter.viscosityData.has(key)) {
      let value = Emitter.viscosityData.get(key)
      if (value == undefined) {
        listener();
      } else {
        listener(...value);
      }
    }
    return item
  }

  /**
   * 取消监听
   * @param listener
   */
  public off(listener: EmitterItem): void {
    let items = Emitter.events.get(listener.key)
    if (!items) {
      return;
    }
    items = items.filter((it)=> {
      return it !== listener;
    })
    Emitter.events.set(listener.key, items);
  }

  /**
   * 发布普通消息
   * @param key
   * @param args
   */
  public emmit<T>(key: string, ...args: T[]) {
    let items = Emitter.events.get(key)
    if (!items || items.length == 0) {
      return;
    }

    items.forEach((item: EmitterItem, index: number) => {
      if (typeof item.listener === 'function') {
        item.listener(...args)
      }
    });
  }

  /**
   * 发布粘性消息
   * @param key
   * @param args
   */
  public emmitViscosity<T>(key: string, ...args: T[]) {
    this.emmit(key, ...args);
    Emitter.viscosityData.set(key, args as EmitterAllType[]);
  }

  /**
   * 移除粘性消息
   * @param key
   */
  public deleteViscosity<T>(key: string) {
    if (Emitter.viscosityData.has(key)) {
      Emitter.viscosityData.delete(key)
    }
  }

  /**
   * 删除所有监听
   */
  public removeAllListener() {
    Emitter.events = new Map;
  }

}