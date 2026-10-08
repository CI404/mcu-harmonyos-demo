import { Nav } from '../common/Nav';
import { SessionManager } from '../common/SessionManager';
import { PageHeader } from '../view/CommonComponents';

interface HubItem {
  title: string;
  icon: string;
  page: string;
  color: string;
}

@Component
export struct StudentHubPage {
  @State loggedIn: boolean = false;
  @State account: string = '';
  private items: HubItem[] = [
    { title: '成績查詢', icon: '📊', page: 'pages/GradesPage', color: '#C5283D' },
    { title: '課表查詢', icon: '🗓️', page: 'pages/SchedulePage', color: '#1B4F8A' },
    { title: '考試資訊', icon: '📝', page: 'pages/ExamPage', color: '#7D5BA6' },
    { title: '請假資訊', icon: '📋', page: 'pages/LeavePage', color: '#2A7F62' },
    { title: '圖書館', icon: '📚', page: 'pages/LibraryPage', color: '#B45309' },
    { title: '教室查詢', icon: '🏠', page: 'pages/RoomPage', color: '#E4572E' },
  ];

  async aboutToAppear(): Promise<void> {
    await SessionManager.load();
    this.loggedIn = SessionManager.isLoggedIn();
    this.account = SessionManager.getSession().account;
  }

  private goto(page: string): void {
    if (!this.loggedIn) {
      Nav.push('pages/LoginPage', { redirect: page });
      return;
    }
    Nav.stack.pushPath({ name: page });
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '學生服務', subtitle: 'Student Services' })

      Row({ space: 10 }) {
        Text(this.loggedIn ? `歡迎，${this.account}` : '尚未登入')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
          .layoutWeight(1)
        Button(this.loggedIn ? '登出' : '登入')
          .fontSize(13)
          .height(34)
          .backgroundColor('#B02A30')
          .onClick(async () => {
            if (this.loggedIn) {
              await SessionManager.logout();
              this.loggedIn = false;
              this.account = '';
            } else {
              Nav.push('pages/LoginPage', { redirect: 'pages/StudentHubPage' });
            }
          })
      }
      .width('100%')
      .padding(14)
      .backgroundColor(Color.White)

      Grid() {
        ForEach(this.items, (it: HubItem) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(it.icon)
                .fontSize(28)
              Text(it.title)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A1A1A')
            }
            .width('100%')
            .padding({ top: 18, bottom: 18 })
            .backgroundColor(Color.White)
            .borderRadius(12)
            .onClick(() => this.goto(it.page))
          }
        }, (it: HubItem) => it.title)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('100%')
      .padding(14)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
