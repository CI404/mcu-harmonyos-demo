/**
 * 共用 UI 元件 — 頁首、載入中、空資料、錯誤提示。
 */
import { Nav } from '../common/Nav';

@Component
export struct PageHeader {
  title: string = '';
  subtitle: string = '';
  showBack: boolean = true;
  @Prop collapse: number = 0; // 0=展開, 1=收起

  build() {
    Stack() {
      Row({ space: 8 }) {
        if (this.showBack) {
          Text('‹')
            .fontSize(this.collapse === 1 ? 20 : 24)
            .fontColor('#FFFFFF')
            .animation({ duration: 200, curve: Curve.EaseInOut })
            .onClick(() => {
              Nav.stack.pop();
            })
        }
        Text(this.title)
          .fontSize(this.collapse === 1 ? 14 : 20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .animation({ duration: 200, curve: Curve.EaseInOut })
        if (this.subtitle.length > 0) {
          Text(this.subtitle)
            .fontSize(11)
            .fontColor('#FFFFFFA6')
            .opacity(this.collapse === 1 ? 0 : 1)
            .maxLines(1)
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 34, left: 14, right: 14 })
      .alignItems(VerticalAlign.Center)

      // 徑向光斑：絕對定位，不佔佈局高度
      Column()
        .width(130)
        .height(120)
        .radialGradient({
          center: [65, 60],
          radius: 65,
          colors: [['#2EFFFFFF', 0.0], ['#00FFFFFF', 1.0]]
        })
        .opacity(this.collapse === 1 ? 0 : 1)
        .animation({ duration: 200, curve: Curve.EaseInOut })
        .position({ x: '74%', y: -42 })
        .hitTestBehavior(HitTestMode.None)
    }
    .width('100%')
    .height(this.collapse === 1 ? 74 : 90)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .animation({ duration: 200, curve: Curve.EaseInOut })
    .clip(true)
    .linearGradient({
      direction: GradientDirection.RightBottom,
      colors: [['#F06B75', 0.0], ['#D44850', 0.3], ['#B02A30', 0.55], ['#7E1D23', 1.0]]
    })
    .shadow({
      radius: 8,
      color: '#1E000000',
      offsetX: 0,
      offsetY: 3
    })
  }
}

@Component
export struct LoadingView {
  text: string = '資料載入中，請稍候…';

  build() {
    Column({ space: 12 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#B02A30')
      Text(this.text)
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(40)
  }
}

@Component
export struct EmptyView {
  text: string = '查無資料';
  icon: string = '🗂️';

  build() {
    Column({ space: 10 }) {
      Text(this.icon)
        .fontSize(44)
      Text(this.text)
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(40)
  }
}

@Component
export struct ErrorView {
  text: string = '連線異常，請稍後再試';
  detail: string = '';
  retry: () => void = () => {};

  build() {
    Column({ space: 14 }) {
      Text('⚠️')
        .fontSize(40)
      Text(this.text)
        .fontSize(14)
        .fontColor('#999999')
        .textAlign(TextAlign.Center)
      if (this.detail.length > 0) {
        Scroll() {
          Text(this.detail)
            .fontSize(11)
            .fontColor('#555555')
            .width('100%')
            .copyOption(CopyOptions.LocalDevice)
        }
        .width('100%')
        .constraintSize({ maxHeight: 280 })
        .backgroundColor('#F2F3F5')
        .borderRadius(8)
        .padding(10)
        .scrollBar(BarState.Auto)
      }
      Button('重新載入')
        .fontSize(14)
        .backgroundColor('#B02A30')
        .height(40)
        .onClick(() => {
          this.retry();
        })
    }
    .width('100%')
    .padding(20)
  }
}
