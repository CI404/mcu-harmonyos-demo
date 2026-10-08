import { Nav } from '../common/Nav';
import { SessionManager } from '../common/SessionManager';

@Component
export struct LoginPage {
  @State account: string = '';
  @State password: string = '';
  @State errorMsg: string = '';
  private redirect: string = '';

  /** Demo 登入：不連網、不驗證，直接建立展示用會話 */
  doLogin(): void {
    if (this.account.trim().length === 0) {
      this.errorMsg = '請輸入展示用的帳號（任意字串）';
      return;
    }
    this.errorMsg = '';
    SessionManager.demoLogin(this.account.trim());
    try {
      this.getUIContext().getPromptAction().showToast({ message: 'Demo 登入成功' });
    } catch (e) {
      // ignore
    }
    if (this.redirect.length > 0) {
      Nav.stack.replacePath({ name: this.redirect });
    } else {
      Nav.stack.pop();
    }
  }

  build() {
    NavDestination() {
    Column() {
      Row({ space: 8 }) {
        Text('‹')
          .fontSize(28)
          .fontColor('#1A1A1A')
          .onClick(() => Nav.stack.pop())
        Text('登入')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      .width('100%')
      .padding(16)

      Column({ space: 18 }) {
        Column({ space: 6 }) {
          Text('銘傳大學 Demo')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#B02A30')
          Text('展示用登入（不需真實帳號）')
            .fontSize(13)
            .fontColor('#999999')
        }
        .padding({ top: 8, bottom: 8 })

        Column({ space: 12 }) {
          TextInput({ placeholder: '任意帳號 / 暱稱', text: this.account })
            .height(50)
            .fontSize(16)
            .backgroundColor('#F2F3F5')
            .borderRadius(12)
            .onChange((v: string) => {
              this.account = v;
            })

          TextInput({ placeholder: '密碼（可留空）', text: this.password })
            .height(50)
            .fontSize(16)
            .type(InputType.Password)
            .backgroundColor('#F2F3F5')
            .borderRadius(12)
            .onChange((v: string) => {
              this.password = v;
            })

          if (this.errorMsg.length > 0) {
            Text(this.errorMsg)
              .fontSize(13)
              .fontColor('#C5283D')
              .width('100%')
          }

          Button('Demo 登入')
            .width('100%')
            .height(50)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#B02A30')
            .onClick(() => {
              this.doLogin();
            })
        }
      }
      .width('100%')
      .padding({ left: 28, right: 28, top: 8 })

      Blank()

      Text('此為展示用 Demo，不連線、不驗證帳號')
        .fontSize(12)
        .fontColor('#AAAAAA')
        .padding({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    }
    .hideTitleBar(true)
    .onReady((ctx: NavDestinationContext) => {
      const p = ctx.pathInfo.param as Record<string, string>;
      if (p !== undefined && p['redirect'] !== undefined) {
        this.redirect = p['redirect'];
      }
    })
  }
}
