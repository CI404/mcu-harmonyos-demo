/**
 * 會話管理（Demo 版）— 不連網、無 token。
 * 僅管理本機展示用的登入狀態與校區/學期偏好。
 */
import { preferences } from '@kit.ArkData';
import { STORAGE_KEY } from './Constants';
import { AppContext } from './AppContext';

export interface Session {
  account: string;
  campus: string;
  sem: string;
  loggedIn: boolean;
}

/** 初始化 AppStorage 登入狀態鍵，確保 Index 的 @StorageProp 綁定有效 */
AppStorage.setOrCreate('mcu_logged_in', false);
AppStorage.setOrCreate('mcu_account', '');
AppStorage.setOrCreate('mcu_campus', '台北');

let session: Session = {
  account: '',
  campus: '台北',
  sem: '1132',
  loggedIn: false,
};

export class SessionManager {
  private static async openPref(): Promise<preferences.Preferences | null> {
    const ctx = AppContext.get();
    if (ctx === null) {
      return null;
    }
    try {
      return await preferences.getPreferences(ctx, 'mcu_store');
    } catch (e) {
      return null;
    }
  }

  static async load(): Promise<Session> {
    try {
      const pref = await SessionManager.openPref();
      if (pref !== null) {
        session.campus = pref.getSync(STORAGE_KEY.CAMPUS, '台北') as string;
        session.sem = pref.getSync(STORAGE_KEY.SEM, '1132') as string;
      }
    } catch (e) {
      // ignore
    }
    SessionManager.syncStorage();
    return session;
  }

  /** Demo 登入：不驗證、不連網，直接以輸入的帳號建立展示用會話 */
  static demoLogin(account: string): void {
    session.account = account.length > 0 ? account : 'DemoUser';
    session.loggedIn = true;
    SessionManager.syncStorage();
  }

  static logout(): void {
    session.account = '';
    session.loggedIn = false;
    SessionManager.syncStorage();
  }

  static async saveCampus(campus: string): Promise<void> {
    session.campus = campus;
    try {
      const pref = await SessionManager.openPref();
      if (pref !== null) {
        await pref.put(STORAGE_KEY.CAMPUS, campus);
        await pref.flush();
      }
    } catch (e) {
      // ignore
    }
    SessionManager.syncStorage();
  }

  static async saveSem(sem: string): Promise<void> {
    session.sem = sem;
    try {
      const pref = await SessionManager.openPref();
      if (pref !== null) {
        await pref.put(STORAGE_KEY.SEM, sem);
        await pref.flush();
      }
    } catch (e) {
      // ignore
    }
  }

  static getSession(): Session {
    return session;
  }

  static isLoggedIn(): boolean {
    return session.loggedIn;
  }

  private static syncStorage(): void {
    AppStorage.setOrCreate('mcu_logged_in', session.loggedIn);
    AppStorage.setOrCreate('mcu_account', session.account);
    AppStorage.setOrCreate('mcu_campus', session.campus);
  }
}
