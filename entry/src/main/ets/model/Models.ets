/**
 * 資料模型 — 展示用資料結構（已移除登入 token 等認證型別）。
 */

/** 新聞項目 */
export interface NewsItem {
  title: string;
  link: string;
  pubDate: string;
  description: string;
}

/** 校車站點即時狀態 */
export interface BusStopStatus {
  stopid: number;
  name: string;
  status: string;
  arriveTime: string;
}

/** 學生課表項目 */
export interface ScheduleItem {
  cls?: string;      // 班級代號
  cour?: string;     // 科目代號
  cnm?: string;      // 科目名稱
  day?: string;      // 星期
  sec?: string;      // 節次
  rm?: string;       // 教室編號
  tname?: string;    // 教師
}

/** 成績項目 */
export interface GradeItem {
  yysm: string;      // 學年度/學期
  cnm: string;       // 科目名稱
  credit: string;    // 學分
  score: string;     // 成績
  grade: string;     // 等第
}

/** 考試資訊 */
export interface ExamItem {
  date: string;
  day: string;
  period: string;
  course: string;
  room: string;
  seat: string;
}

/** 請假資訊 */
export interface LeaveItem {
  date: string;
  type: string;
  status: string;
  note: string;
}

/** 借閱圖書 */
export interface BorrowedBook {
  bookname: string;
  author: string;
  borrowDate: string;
  dueDate: string;
  location: string;
}

/** 租屋物件 */
export interface RentItem {
  Id: string;
  Cname: string;
  Tname: string;
  Grade: string;
  TotalCount: string;
  PicPath: string;
}

/** 校園生活分類 */
export interface LifeCategory {
  Id: string;
  Cname: string;
  Tname: string;
}

/** 訊息/公告 */
export interface NoteItem {
  Id: string;
  title: string;
  content: string;
  date: string;
  unread: boolean;
}

/** 主選單項目 */
export interface MenuItem {
  id: string;
  title: string;
  subtitle: string;
  icon: string;     // 使用 systemResource 或自訂圖示 key
  page: string;     // 目標頁面
  needLogin: boolean;
  category: string;
}
