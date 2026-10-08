/**
 * 銘傳大學 Demo 應用程式 — 全域常數與靜態展示資料。
 * 本 demo 版本已移除校方 API 端點與任何 token，不進行任何網路連線。
 * 以下皆為公開、靜態的展示內容。
 */

/** 校園地標（經緯度，供系統地圖開啟） */
export interface CampusSpot {
  name: string;
  lat: number;
  lng: number;
}

export const CAMPUS_SPOTS: CampusSpot[] = [
  { name: '銘傳大學(對面)', lat: 25.0878411, lng: 121.52699 },
  { name: '銘傳大學(門口)', lat: 25.0874668, lng: 121.5257973 },
  { name: '陽明戲院(院口)', lat: 25.0876, lng: 121.5254 },
  { name: '士林夜市(銘傳會館)', lat: 25.0894, lng: 121.5255 },
  { name: '劍潭捷運站', lat: 25.0842, lng: 121.5243 },
];

/** 校園電話（公開聯絡資訊） */
export interface PhoneEntry {
  campus: string;
  dept: string;
  number: string;
}

export const PHONE_BOOK: PhoneEntry[] = [
  { campus: '台北', dept: '總機', number: '(02)28824564' },
  { campus: '台北', dept: '教務處', number: '(02)28829595' },
  { campus: '台北', dept: '學務處', number: '(02)28809719' },
  { campus: '台北', dept: '總務處', number: '(02)28836317' },
  { campus: '台北', dept: '圖書館', number: '(02)28809714' },
  { campus: '台北', dept: '資訊網路處', number: '(02)28833221' },
  { campus: '台北', dept: '進修推廣處', number: '(02)25433535' },
  { campus: '台北', dept: '國際教育交流處', number: '(02)28813856' },
  { campus: '台北', dept: '校友服務中心', number: '(02)28881995' },
  { campus: '桃園', dept: '總機', number: '(03)3507001' },
  { campus: '桃園', dept: '教務處', number: '(03)3509495' },
  { campus: '金門', dept: '金門校區', number: '(082)355233' },
  { campus: '金門', dept: '金門行政', number: '(082)330596' },
  { campus: '金門', dept: '金門學務', number: '(082)352260' },
  { campus: '金門', dept: '金門圖書', number: '(082)332546' },
  { campus: '金門', dept: '金門推廣', number: '(082)352854' },
];

/** 校車站牌（展示用） */
export interface BusStop {
  id: number;
  name: string;
}

export const BUS_STOPS: BusStop[] = [
  { id: 1, name: '銘傳大學(對面)' },
  { id: 2, name: '銘傳大學(門口)' },
  { id: 3, name: '陽明戲院(院口)' },
  { id: 4, name: '陽明戲院(對面)' },
  { id: 5, name: '劍潭捷運站(中山北路)' },
  { id: 6, name: '劍潭捷運站(基河路)' },
  { id: 7, name: '劍潭捷運站' },
  { id: 8, name: '士林夜市(銘傳會館對面)' },
  { id: 9, name: '士林夜市(銘傳會館)' },
];

/** 校車狀態碼 → 文字 */
export function busStatusText(code: number): string {
  if (code === -1 || code === 0) {
    return '尚未發車';
  }
  if (code === -2) {
    return '交管不停靠';
  }
  if (code === -3) {
    return '末班車已過';
  }
  if (code === -4) {
    return '今日未營運';
  }
  return '';
}

/** 本機儲存鍵（僅校區/學期等無害的展示偏好，無任何 token/帳號） */
export interface StorageKeys {
  CAMPUS: string;
  SEM: string;
}

export const STORAGE_KEY: StorageKeys = {
  CAMPUS: 'mcu_campus',
  SEM: 'mcu_sem',
};
