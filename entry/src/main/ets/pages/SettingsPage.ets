import { Nav } from '../common/Nav';
import { bundleManager } from '@kit.AbilityKit';
import { SessionManager } from '../common/SessionManager';
import { PageHeader } from '../view/CommonComponents';

@Component
export struct SettingsPage {
  @State loggedIn: boolean = false;
  @State account: string = '';
  @State campus: string = '台北';
  @State sem: string = '1132';
  @State version: string = '1.0.0';
  @State collapse: number = 0;
  private campuses: string[] = ['台北', '桃園', '金門'];

  async aboutToAppear(): Promise<void> {
    await SessionManager.load();
    const s = SessionManager.getSession();
    this.loggedIn = SessionManager.isLoggedIn();
    this.account = s.account;
    this.campus = s.campus;
    this.sem = s.sem;
    this.checkVersion();
  }

  async checkVersion(): Promise<void> {
    try {
      const info: bundleManager.BundleInfo =
        bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      if (info.versionName.length > 0) {
        this.version = `${info.versionName} (${info.versionCode})`;
      }
    } catch (e) {
      // 保留預設值
    }
  }

  async setCampus(c: string): Promise<void> {
    this.campus = c;
    await SessionManager.saveCampus(c);
    try {
      this.getUIContext().getPromptAction().showToast({ message: `已切換至${c}校區` });
    } catch (e) {
      // ignore
    }
  }

  async saveSem(): Promise<void> {
    await SessionManager.saveSem(this.sem);
    try {
      this.getUIContext().getPromptAction().showToast({ message: `學期已設為 ${this.sem}` });
    } catch (e) {
      // ignore
    }
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '設定', subtitle: 'Settings', collapse: this.collapse })

      Scroll() {
        Column({ space: 12 }) {
          // 校區切換
          Column({ space: 10 }) {
            Text('校區')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
              .width('100%')
            Row({ space: 8 }) {
              ForEach(this.campuses, (c: string) => {
                Text(c)
                  .fontSize(14)
                  .fontColor(this.campus === c ? Color.White : '#1A1A1A')
                  .padding({ left: 18, right: 18, top: 8, bottom: 8 })
                  .backgroundColor(this.campus === c ? '#B02A30' : '#F2F3F5')
                  .borderRadius(18)
                  .onClick(() => this.setCampus(c))
              }, (c: string) => c)
            }
            .width('100%')
          }
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)

          // 學期（成績查詢用）
          Column({ space: 10 }) {
            Text('學期（成績查詢）')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
              .width('100%')
            Row({ space: 8 }) {
              TextInput({ placeholder: '例如 1131', text: this.sem })
                .height(44)
                .fontSize(15)
                .backgroundColor('#F2F3F5')
                .borderRadius(10)
                .layoutWeight(1)
                .onChange((v: string) => {
                  this.sem = v;
                })
              Button('儲存')
                .fontSize(14)
                .height(44)
                .backgroundColor('#B02A30')
                .onClick(() => this.saveSem())
            }
            .width('100%')
            Text('格式：學年度(3碼)+學期(1或2)，例如 1131 表示 113 學年度第 1 學期')
              .fontSize(11)
              .fontColor('#999999')
              .width('100%')
          }
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)

          // 帳號
          Column({ space: 10 }) {
            Text('帳號')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
              .width('100%')
            if (this.loggedIn) {
              Row() {
                Text(this.account)
                  .fontSize(15)
                  .fontColor('#1A1A1A')
                  .layoutWeight(1)
                Button('登出')
                  .fontSize(13)
                  .height(34)
                  .backgroundColor('#C5283D')
                  .onClick(async () => {
                    await SessionManager.logout();
                    this.loggedIn = false;
                    this.account = '';
                    try {
                      this.getUIContext().getPromptAction().showToast({ message: '已登出' });
                    } catch (e) {
                      // ignore
                    }
                    Nav.stack.pop();
                  })
              }
              .width('100%')
            } else {
              Button('登入')
                .width('100%')
                .height(42)
                .fontSize(15)
                .backgroundColor('#B02A30')
                .onClick(() => Nav.stack.pushPath({ name: 'pages/LoginPage' }))
            }
          }
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)

          // 關於
          Column({ space: 10 }) {
            Text('關於')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
              .width('100%')
            Row() {
              Text('應用程式版本')
                .fontSize(14)
                .fontColor('#1A1A1A')
                .layoutWeight(1)
              Text(this.version)
                .fontSize(14)
                .fontColor('#999999')
            }
            .width('100%')
            Row() {
              Text('隱私權政策')
                .fontSize(14)
                .fontColor('#1A1A1A')
                .layoutWeight(1)
              Text('›')
                .fontSize(20)
                .fontColor('#CCCCCC')
            }
            .width('100%')
            .onClick(() => Nav.stack.pushPath({ name: 'pages/AboutPage' }))
          }
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .onDidScroll((xOffset: number, yOffset: number) => {
        this.collapse = yOffset > 80 ? 1 : 0;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
