import { Nav } from '../common/Nav';
import { PageHeader } from '../view/CommonComponents';

interface AboutLink {
  title: string;
  kind: string;
}

@Component
export struct AboutPage {
  @State collapse: number = 0;
  private links: AboutLink[] = [
    { title: '意見回饋 / 問卷', kind: '意見回饋' },
    { title: '招生資訊', kind: '招生資訊' },
    { title: 'Moodle 數位學習', kind: 'Moodle' },
    { title: '網路電視台', kind: '網路電視' },
    { title: '社團資訊', kind: '社團' },
  ];

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '關於銘傳', subtitle: 'About Ming Chuan', collapse: this.collapse })

      Scroll() {
        Column({ space: 12 }) {
          Column({ space: 8 }) {
            Text('🏛️')
              .fontSize(44)
            Text('銘傳大學')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#B02A30')
            Text('Ming Chuan University')
              .fontSize(14)
              .fontColor('#666666')
            Text('誠、樸、敬、毅')
              .fontSize(13)
              .fontColor('#999999')
          }
          .width('100%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(12)

          Column({ space: 8 }) {
            Text('校區資訊')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
              .width('100%')
            Text('台北校區：111 臺北市士林區中山北路五段 250 號')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
            Text('桃園校區：333 桃園市龜山區德明路 5 號')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
            Text('金門校區：890 金門縣金沙鎮西園里德明路 105 號')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
            Text('總機：(02)28824564 ／ (03)3507001')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)

          Column({ space: 0 }) {
            ForEach(this.links, (l: AboutLink) => {
              Row() {
                Text(l.title)
                  .fontSize(14)
                  .fontColor('#1A1A1A')
                  .layoutWeight(1)
                Text('›')
                  .fontSize(20)
                  .fontColor('#CCCCCC')
              }
              .width('100%')
              .padding(14)
              .onClick(() => {
                Nav.push('pages/WebPage', { kind: l.kind, title: l.title });
              })
              Divider().color('#F0F0F0')
            }, (l: AboutLink) => l.title)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)

          Text('本應用程式為 HarmonyOS 原生重構版，功能與資料來源對應原 Android 版銘傳大學 App。')
            .fontSize(12)
            .fontColor('#AAAAAA')
            .width('100%')
            .padding(8)
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
