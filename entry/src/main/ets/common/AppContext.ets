/**
 * 應用程式層級的 AbilityContext 持有者。
 * 於 EntryAbility.onCreate 設定，供工具類（無 this 上下文）取用，
 * 取代已棄用的全域 getContext()。
 */
import { common } from '@kit.AbilityKit';

let appContext: common.UIAbilityContext | null = null;

export class AppContext {
  static set(ctx: common.UIAbilityContext): void {
    appContext = ctx;
  }

  static get(): common.UIAbilityContext | null {
    return appContext;
  }
}
