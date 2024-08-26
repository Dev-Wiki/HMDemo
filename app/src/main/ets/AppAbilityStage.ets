import { AbilityConstant, AbilityStage, Configuration, Want } from '@kit.AbilityKit';

const TAG = '[AbilityStage]';

export default class AppAbilityStage extends AbilityStage {

  onCreate(): void {
    console.log(TAG, "onCreate")
  }

  // onAcceptWant(want: Want): string {
  // }

  // onNewProcessRequest(want: Want): string {
  // }

  onConfigurationUpdate(newConfig: Configuration): void {
  }

  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
  }
}