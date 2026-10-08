import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { SessionManager } from '../common/SessionManager';
import { AppContext } from '../common/AppContext';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN, 'MCU', 'EntryAbility onCreate');
    AppContext.set(this.context);
    SessionManager.load();
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'MCU', 'EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // 沉浸式：內容延伸至狀態欄，狀態欄透明
    try {
      const win = windowStage.getMainWindowSync();
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        statusBarContentColor: '#FFFFFF'
      });
    } catch (e) {
      // ignore
    }
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'MCU', 'Failed to load content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'MCU', 'Succeeded in loading content.');
    });
  }

  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, 'MCU', 'onWindowStageDestroy');
  }

  onForeground(): void {
    hilog.info(DOMAIN, 'MCU', 'onForeground');
  }

  onBackground(): void {
    hilog.info(DOMAIN, 'MCU', 'onBackground');
  }
}
