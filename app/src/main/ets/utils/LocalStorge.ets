
import { Context } from '@kit.AbilityKit';
import dataPreferences from '@ohos.data.preferences';
import { Log } from './Log';

export class LocalStorageKey {
  static readonly KEY_SERVER_CONFIG = "key_config";
}

export class LocalStorage {

  private static instance: LocalStorage;
  private static lock: boolean = false;
  private static readonly XY_DP_Name = "LocalData";
  static getInstance(): LocalStorage {
    if (!LocalStorage.instance) {
      if (!LocalStorage.lock) {
        LocalStorage.lock = true;
        LocalStorage.instance = new LocalStorage();
        LocalStorage.lock = false;
      }
    }
    return LocalStorage.instance;
  }

  private context: Context | null = null;
  private preferences: dataPreferences.Preferences | null = null;
  private constructor() {
  }

  public init(context: Context): void {
    if (!this.context) {
      this.context = context.getApplicationContext();
      let options: dataPreferences.Options = { name: LocalStorage.XY_DP_Name };
      this.preferences = dataPreferences.getPreferencesSync(this.context, options);
    } else {
      Log.i("LocalStorage is already init.")
    }
  }

  public putData(key: string, value: dataPreferences.ValueType) {
    Log.i(`put sp data, key:${key}, value:${value}`)
    this.preferences?.putSync(key, value);
    this.preferences?.flush();
  }

  public clearData(key: string) {
    this.preferences?.delete(key);
    this.preferences?.flush();
  }

  public getData(key: string, defaultValue: dataPreferences.ValueType): dataPreferences.ValueType | undefined {
    let value = this.preferences?.getSync(key, defaultValue);
    Log.i(`get sp data, key:${key}, value:${value}`)
    return value;
  }

  public getObject<T>(key: string): T {
    let value = this.getData(key, "{}") as string;
    if (value.toString().length > 0) {
      return JSON.parse(value) as T;
    }
    return "{}" as T;
  }
}