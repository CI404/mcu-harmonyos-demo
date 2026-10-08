import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface ScheduleRow {
  sec: string;
  mon: string;
  tue: string;
  wed: string;
  thr: string;
  fir: string;
  sat: string;
  sun: string;
}

interface PeriodCourse {
  sec: string;
  course: string;
}

interface DaySchedule {
  day: string;
  color: string;
  courses: PeriodCourse[];
}

@Component
export struct SchedulePage {
  @State days: DaySchedule[] = [];
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = false;
    // Demo 假資料
    const rows: ScheduleRow[] = [
      { sec: '1', mon: '程式設計', tue: '資料結構', wed: '', thr: '', fir: '', sat: '', sun: '' },
      { sec: '2', mon: '', tue: '作業系統', wed: '計算機網路', thr: '', fir: '', sat: '', sun: '' },
      { sec: '3', mon: '線性代數', tue: '', wed: '', thr: '資料庫系統', fir: '', sat: '', sun: '' },
    ];
    this.days = this.buildDays(rows);
    this.error = this.days.length === 0;
    this.loading = false;
  }

  /** 將「節次 × 星期」的表格轉成「按星期分組」的清單 */
  private buildDays(rows: ScheduleRow[]): DaySchedule[] {
    const weekdays: DaySchedule[] = [
      { day: '週一', color: '#1B4F8A', courses: [] },
      { day: '週二', color: '#1B4F8A', courses: [] },
      { day: '週三', color: '#1B4F8A', courses: [] },
      { day: '週四', color: '#1B4F8A', courses: [] },
      { day: '週五', color: '#1B4F8A', courses: [] },
      { day: '週六', color: '#B45309', courses: [] },
      { day: '週日', color: '#C5283D', courses: [] },
    ];
    for (const r of rows) {
      if (r.mon.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.mon };
        weekdays[0].courses.push(pc);
      }
      if (r.tue.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.tue };
        weekdays[1].courses.push(pc);
      }
      if (r.wed.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.wed };
        weekdays[2].courses.push(pc);
      }
      if (r.thr.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.thr };
        weekdays[3].courses.push(pc);
      }
      if (r.fir.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.fir };
        weekdays[4].courses.push(pc);
      }
      if (r.sat.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.sat };
        weekdays[5].courses.push(pc);
      }
      if (r.sun.length > 0) {
        const pc: PeriodCourse = { sec: r.sec, course: r.sun };
        weekdays[6].courses.push(pc);
      }
    }
    const result: DaySchedule[] = [];
    result.push(weekdays[0]);
    result.push(weekdays[1]);
    result.push(weekdays[2]);
    result.push(weekdays[3]);
    result.push(weekdays[4]);
    if (weekdays[5].courses.length > 0) {
      result.push(weekdays[5]);
    }
    if (weekdays[6].courses.length > 0) {
      result.push(weekdays[6]);
    }
    return result;
  }

  @Builder
  DayCard(d: DaySchedule) {
    Column({ space: 0 }) {
      Row({ space: 10 }) {
        Text(d.day)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        Text(`${d.courses.length} 門課`)
          .fontSize(12)
          .fontColor('#FFFFFFCC')
        Blank()
      }
      .width('100%')
      .padding({ left: 18, right: 18, top: 13, bottom: 13 })
      .linearGradient({
        direction: GradientDirection.Right,
        colors: [[d.color, 0.0], [this.lighten(d.color), 1.0]]
      })

      if (d.courses.length === 0) {
        Text('本日無課程')
          .fontSize(14)
          .fontColor('#AAAAAA')
          .padding(20)
          .width('100%')
          .textAlign(TextAlign.Center)
      }

      ForEach(d.courses, (pc: PeriodCourse) => {
        Row({ space: 14 }) {
          Text(pc.sec)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor(d.color)
            .width(38)
            .height(38)
            .textAlign(TextAlign.Center)
            .backgroundColor(d.color + '14')
            .borderRadius(12)
            .shadow({
              radius: 8,
              color: d.color + '38',
              offsetX: 0,
              offsetY: 2
            })
          Column({ space: 3 }) {
            Text(pc.course)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
              .textAlign(TextAlign.Start)
              .width('100%')
            Text(`第 ${pc.sec} 節`)
              .fontSize(11)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 18, right: 18, top: 14, bottom: 14 })
        .alignItems(VerticalAlign.Top)
      }, (pc: PeriodCourse) => d.day + pc.sec + pc.course)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .clip(true)
    .shadow({
      radius: 16,
      color: '#16000000',
      offsetX: 0,
      offsetY: 6
    })
  }

  /** 傳入主題色，回傳淺化後的漸變端點色 */
  private lighten(color: string): string {
    if (color === '#1B4F8A') {
      return '#3A74B8';
    }
    if (color === '#B45309') {
      return '#D97A2E';
    }
    if (color === '#C5283D') {
      return '#E2545E';
    }
    return color;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '課表查詢', subtitle: 'Personal Schedule', collapse: this.collapse })

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', retry: () => this.load() })
      } else {
        List({ space: 14 }) {
          ForEach(this.days, (d: DaySchedule) => {
            ListItem() {
              this.DayCard(d)
            }
          }, (d: DaySchedule) => d.day)
        }
        .width('100%')
        .padding(14)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .onScrollIndex((start: number) => {
          this.collapse = start > 0 ? 1 : 0;
        })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#F7FAFD', 0.0], ['#EDF1F7', 1.0]]
    })
    }
    .hideTitleBar(true)
  }
}
