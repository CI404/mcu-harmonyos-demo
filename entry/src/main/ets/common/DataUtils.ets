/**
 * 資料解析工具 — 因後端回傳結構不完全固定，提供寬鬆的欄位提取。
 * 全部以 ArkTS 允許的 `Object` / `Record<string, Object | undefined>` 型別實作。
 */

/** 將單一值轉為字串（null/undefined 回傳空字串） */
function toStr(v: Object | undefined): string {
  if (v === undefined || v === null) {
    return '';
  }
  const s: string = `${v}`;
  if (s === 'undefined' || s === 'null' || s === '[object Object]') {
    return '';
  }
  return s;
}

/** 從回傳物件中找出陣列（可能直接是陣列、或在 data/items/list 等鍵下） */
export function toArray(data: object): object[] {
  if (data === null || data === undefined) {
    return [];
  }
  if (Array.isArray(data)) {
    return data as object[];
  }
  const o: Record<string, Object | undefined> = data as Record<string, Object | undefined>;
  const keys: string[] = ['data', 'Data', 'items', 'item', 'list', 'List', 'rows', 'result', 'Result',
    'records', 'content', 'grade', 'Grade', 'grades', 'Grades', 'Value', 'values'];
  for (const key of keys) {
    const v: Object | undefined = o[key];
    if (v !== undefined && v !== null) {
      if (Array.isArray(v)) {
        return v as object[];
      }
      if (typeof v === 'object') {
        const inner: object[] = toArray(v as object);
        if (inner.length > 0) {
          return inner;
        }
      }
    }
  }
  return [];
}

/** 取得物件中的第一個非空字串值（按候選鍵順序） */
export function pick(obj: object, keys: string[]): string {
  if (obj === null || obj === undefined) {
    return '';
  }
  const o: Record<string, Object | undefined> = obj as Record<string, Object | undefined>;
  for (const key of keys) {
    const v: Object | undefined = o[key];
    const s: string = toStr(v);
    if (s.length > 0) {
      return s;
    }
  }
  return '';
}

/** 去除 HTML 標籤與常見實體 */
export function stripHtml(html: string): string {
  if (!html) {
    return '';
  }
  let result: string = html;
  result = result.replace(/<[^>]+>/g, '');
  result = result.replace(/&nbsp;/g, ' ');
  result = result.replace(/&amp;/g, '&');
  result = result.replace(/&lt;/g, '<');
  result = result.replace(/&gt;/g, '>');
  result = result.replace(/&quot;/g, '"');
  result = result.replace(/&#\d+;/g, '');
  return result.trim();
}
