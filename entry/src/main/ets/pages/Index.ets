import { SessionManager } from '../common/SessionManager';
import { Nav } from '../common/Nav';
import { NewsPage } from './NewsPage';
import { CalendarPage } from './CalendarPage';
import { BusPage } from './BusPage';
import { CampusGuidePage } from './CampusGuidePage';
import { CampusLifePage } from './CampusLifePage';
import { LoginPage } from './LoginPage';
import { GradesPage } from './GradesPage';
import { SchedulePage } from './SchedulePage';
import { ExamPage } from './ExamPage';
import { LeavePage } from './LeavePage';
import { LibraryPage } from './LibraryPage';
import { RoomPage } from './RoomPage';
import { PhonePage } from './PhonePage';
import { HousingPage } from './HousingPage';
import { NotePage } from './NotePage';
import { NoteDetailPage } from './NoteDetailPage';
import { WebPage } from './WebPage';
import { AboutPage } from './AboutPage';
import { SettingsPage } from './SettingsPage';
import { StudentHubPage } from './StudentHubPage';

interface MenuEntry {
  title: string;
  subtitle: string;
  icon: string;
  page: string;
  needLogin: boolean;
  color: string;
}

interface MenuGroup {
  title: string;
  items: MenuEntry[];
}

const MENU: MenuGroup[] = [
  {
    title: '校園資訊',
    items: [
      { title: '校園新聞', subtitle: 'News', icon: '📰', page: 'pages/NewsPage', needLogin: false, color: '#E4572E' },
      { title: '行事曆', subtitle: 'Calendar', icon: '📅', page: 'pages/CalendarPage', needLogin: false, color: '#C5283D' },
      { title: '校車時刻', subtitle: 'Bus', icon: '🚌', page: 'pages/BusPage', needLogin: false, color: '#1B4F8A' },
      { title: '校園導覽', subtitle: 'Map', icon: '🗺️', page: 'pages/CampusGuidePage', needLogin: false, color: '#2A7F62' },
      { title: '校園生活', subtitle: 'Life', icon: '🏫', page: 'pages/CampusLifePage', needLogin: false, color: '#7D5BA6' },
      { title: '交通資訊', subtitle: 'Transport', icon: '🚉', page: 'pages/WebPage', needLogin: false, color: '#B45309' },
    ],
  },
  {
    title: '學習服務',
    items: [
      { title: '成績查詢', subtitle: 'Grades', icon: '📊', page: 'pages/GradesPage', needLogin: true, color: '#C5283D' },
      { title: '課表查詢', subtitle: 'Schedule', icon: '🗓️', page: 'pages/SchedulePage', needLogin: true, color: '#1B4F8A' },
      { title: '考試資訊', subtitle: 'Exam', icon: '📝', page: 'pages/ExamPage', needLogin: true, color: '#7D5BA6' },
      { title: '請假資訊', subtitle: 'Leave', icon: '📋', page: 'pages/LeavePage', needLogin: true, color: '#2A7F62' },
      { title: '圖書館', subtitle: 'Library', icon: '📚', page: 'pages/LibraryPage', needLogin: true, color: '#B45309' },
      { title: '教室查詢', subtitle: 'Room', icon: '🏠', page: 'pages/RoomPage', needLogin: true, color: '#E4572E' },
    ],
  },
  {
    title: '生活服務',
    items: [
      { title: '電話查詢', subtitle: 'Phone', icon: '☎️', page: 'pages/PhonePage', needLogin: false, color: '#2A7F62' },
      { title: '宿舍租屋', subtitle: 'Housing', icon: '🏢', page: 'pages/HousingPage', needLogin: false, color: '#B45309' },
      { title: '校園訊息', subtitle: 'Notes', icon: '💬', page: 'pages/NotePage', needLogin: true, color: '#1B4F8A' },
      { title: '電子公文表單', subtitle: 'E-Form', icon: '📄', page: 'pages/WebPage', needLogin: false, color: '#2A7F62' },
      { title: '意見回饋', subtitle: 'Feedback', icon: '✉️', page: 'pages/WebPage', needLogin: false, color: '#7D5BA6' },
      { title: '關於銘傳', subtitle: 'About', icon: '🏛️', page: 'pages/AboutPage', needLogin: false, color: '#C5283D' },
    ],
  },
];

@Entry
@Component
struct Index {
  @StorageProp('mcu_logged_in') isLoggedIn: boolean = false;
  @StorageProp('mcu_account') account: string = '';
  @StorageProp('mcu_campus') campus: string = '台北';
  @State collapse: number = 0;

  async aboutToAppear(): Promise<void> {
    await SessionManager.load();
  }

  private goto(item: MenuEntry): void {
    if (item.page === 'pages/WebPage') {
      Nav.push('pages/WebPage', { kind: item.title });
      return;
    }
    if (item.needLogin && !this.isLoggedIn) {
      Nav.push('pages/LoginPage', { redirect: item.page });
      return;
    }
    Nav.stack.pushPath({ name: item.page });
  }

  @Builder
  Header() {
    Stack() {
    Row({ space: 10 }) {
      Text('銘傳大學')
        .fontSize(this.collapse === 1 ? 16 : 22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .animation({ duration: 180, curve: Curve.EaseInOut })
      Text('Ming Chuan University')
        .fontSize(11)
        .fontColor('#FFFFFFA6')
        .opacity(this.collapse === 1 ? 0 : 1)
        .animation({ duration: 180, curve: Curve.EaseInOut })
      Blank()
      if (this.isLoggedIn) {
        Row({ space: 8 }) {
          Text(`${this.campus}校區`)
            .fontSize(12)
            .fontColor('#FFFFFF')
          Text(this.account)
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .padding({ left: 16, right: 16, top: 9, bottom: 9 })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#99FFFFFF', 0.0], ['#26FFFFFF', 0.18], ['#00FFFFFF', 0.45], ['#00FFFFFF', 1.0]]
        })
        .borderRadius(24)
        .border({ width: 1.5, color: '#8CFFFFFF' })
        .shadow({ radius: 10, color: '#26000000', offsetX: 0, offsetY: 4 })
        .onClick(() => {
          Nav.stack.pushPath({ name: 'pages/SettingsPage' });
        })
      } else {
        Row({ space: 6 }) {
          Text('登入')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
          Text('›')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
        .padding({ left: 16, right: 14, top: 9, bottom: 9 })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#99FFFFFF', 0.0], ['#26FFFFFF', 0.18], ['#00FFFFFF', 0.45], ['#00FFFFFF', 1.0]]
        })
        .borderRadius(24)
        .border({ width: 1.5, color: '#8CFFFFFF' })
        .shadow({ radius: 10, color: '#26000000', offsetX: 0, offsetY: 4 })
        .onClick(() => {
          Nav.stack.pushPath({ name: 'pages/LoginPage' });
        })
      }
    }
    .width('100%')
    .height('100%')
    .padding({ top: 34, left: 20, right: 20 })
    .alignItems(VerticalAlign.Center)

    // 徑向光斑：暖金色光源（沉浸光感）
    Column()
      .width(200)
      .height(180)
      .radialGradient({
        center: [100, 90],
        radius: 100,
        colors: [['#4DFFD8A0', 0.0], ['#00FFD8A0', 1.0]]
      })
      .position({ x: '55%', y: -55 })
      .hitTestBehavior(HitTestMode.None)
    }
    .width('100%')
    .height(90)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .clip(true)
    .linearGradient({
      direction: GradientDirection.RightBottom,
      colors: [['#F06B75', 0.0], ['#D44850', 0.3], ['#B02A30', 0.55], ['#7E1D23', 1.0]]
    })
    .shadow({
      radius: 10,
      color: '#22000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  MenuGroupView(group: MenuGroup) {
    Column({ space: 10 }) {
      Text(group.title)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1A1A')
        .width('100%')
        .padding({ left: 4 })

      Grid() {
        ForEach(group.items, (item: MenuEntry) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(item.icon)
                .fontSize(26)
                .width(46)
                .height(46)
                .textAlign(TextAlign.Center)
                .backgroundColor(item.color + '20')
                .borderRadius(14)
              Text(item.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A1A1A')
              Text(item.subtitle)
                .fontSize(11)
                .fontColor('#999999')
            }
            .width('100%')
            .padding({ top: 12, bottom: 12 })
            .onClick(() => {
              this.goto(item);
            })
          }
        }, (item: MenuEntry) => item.title)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .backgroundColor('#C4FFFFFF')
      .borderRadius(16)
      .padding(8)
      .backgroundBlurStyle(BlurStyle.Thin)
      .shadow({
        radius: 16,
        color: '#14000000',
        offsetX: 0,
        offsetY: 6
      })
    }
    .width('100%')
  }

  @Builder
  PageMap(name: string) {
    if (name === 'pages/NewsPage') {
      NewsPage()
    } else if (name === 'pages/CalendarPage') {
      CalendarPage()
    } else if (name === 'pages/BusPage') {
      BusPage()
    } else if (name === 'pages/CampusGuidePage') {
      CampusGuidePage()
    } else if (name === 'pages/CampusLifePage') {
      CampusLifePage()
    } else if (name === 'pages/LoginPage') {
      LoginPage()
    } else if (name === 'pages/GradesPage') {
      GradesPage()
    } else if (name === 'pages/SchedulePage') {
      SchedulePage()
    } else if (name === 'pages/ExamPage') {
      ExamPage()
    } else if (name === 'pages/LeavePage') {
      LeavePage()
    } else if (name === 'pages/LibraryPage') {
      LibraryPage()
    } else if (name === 'pages/RoomPage') {
      RoomPage()
    } else if (name === 'pages/PhonePage') {
      PhonePage()
    } else if (name === 'pages/HousingPage') {
      HousingPage()
    } else if (name === 'pages/NotePage') {
      NotePage()
    } else if (name === 'pages/NoteDetailPage') {
      NoteDetailPage()
    } else if (name === 'pages/WebPage') {
      WebPage()
    } else if (name === 'pages/AboutPage') {
      AboutPage()
    } else if (name === 'pages/SettingsPage') {
      SettingsPage()
    } else if (name === 'pages/StudentHubPage') {
      StudentHubPage()
    }
  }

  build() {
    Navigation(Nav.stack) {
      // 光斑背景（沉浸光感）
      Stack() {
        Column() {
          Column()
            .width(300)
            .height(300)
            .radialGradient({
              center: [150, 150],
              radius: 150,
              colors: [['#45E2545E', 0.0], ['#00E2545E', 1.0]]
            })
            .position({ x: '45%', y: '12%' })
          Column()
            .width(260)
            .height(260)
            .radialGradient({
              center: [130, 130],
              radius: 130,
              colors: [['#381B4F8A', 0.0], ['#001B4F8A', 1.0]]
            })
            .position({ x: '-15%', y: '42%' })
          Column()
            .width(220)
            .height(220)
            .radialGradient({
              center: [110, 110],
              radius: 110,
              colors: [['#30C5283D', 0.0], ['#00C5283D', 1.0]]
            })
            .position({ x: '60%', y: '58%' })
        }
        .width('100%')
        .height('100%')
        .hitTestBehavior(HitTestMode.None)

        Column() {
          this.Header()

          List({ space: 16 }) {
            ForEach(MENU, (group: MenuGroup) => {
              ListItem() {
                this.MenuGroupView(group)
              }
            }, (group: MenuGroup) => group.title)

            ListItem() {
              Column({ space: 8 }) {
                Text('© 2025 銘傳大學資訊網路處')
                  .fontSize(12)
                  .fontColor('#AAAAAA')
              }
              .width('100%')
              .padding({ top: 8, bottom: 24 })
            }
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16 })
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .onScrollIndex((start: number) => {
            this.collapse = start > 0 ? 1 : 0;
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F7FAFD', 0.0], ['#EDF1F7', 1.0]]
      })
    }
    .navDestination(this.PageMap)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
