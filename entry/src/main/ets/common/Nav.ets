/**
 * 路由參數介面 — ArkTS 要求物件字面量對應「顯式宣告的 interface」，
 * 因此不能直接把 `{ kind: ... }` 塞進 NavPathInfo.param (unknown)。
 */
export interface RouteParam {
  kind?: string;
  title?: string;
  url?: string;
  redirect?: string;
  content?: string;
  date?: string;
}

/**
 * 全域路由堆疊 — 取代已棄用的 @ohos.router。
 * Navigation 宿主（Index）與所有頁面共用同一個 NavPathStack 實例。
 */
export class Nav {
  static stack: NavPathStack = new NavPathStack();

  static push(name: string, param?: RouteParam): void {
    if (param === undefined) {
      Nav.stack.pushPath({ name: name });
    } else {
      Nav.stack.pushPath({ name: name, param: param });
    }
  }

  static replace(name: string, param?: RouteParam): void {
    if (param === undefined) {
      Nav.stack.replacePath({ name: name });
    } else {
      Nav.stack.replacePath({ name: name, param: param });
    }
  }
}
