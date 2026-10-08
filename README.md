# MCU FOR HarmonyOS Demo

銘傳大學 App 的 **HarmonyOS（ArkTS + ArkUI 宣告式 UI）原生 UI 展示 Demo**。

> ⚠️ **本倉庫為「僅展示動畫 / UI 效果」的 Demo 版本**：
> - 已移除校方 API 端點、登入 token 與任何帳號 / 學號資料；
> - **不進行任何網路連線**，無法實際讀寫任何來往數據；
> - 所有列表資料皆為內建的示意假資料。

---

## 特色（動畫 / UI 展示）

| 特性 | 說明 |
|---|---|
| 沉浸式全屏 | 標題欄紅漸變延伸至狀態欄，無縫沉浸 |
| 液態玻璃膠囊 | 右上角登入 / 校區膠囊，頂部高光漸變 + 亮描邊 + 投影 |
| 彩色光斑背景 | 主選單 `radialGradient` 紅 / 藍光斑 + 毛玻璃卡片 |
| 滑動壓縮標題欄 | `List.onScrollIndex` + `@Prop collapse` + `.animation()` |
| 毛玻璃材質 | `backgroundBlurStyle` 卡片與膠囊 |

---

## 技術

- Stage 模型 + ArkTS（嚴格模式）
- `compatibleSdkVersion = 26.0.0`、`targetSdkVersion = 26.0.0`（API 26）
- bundleName：`com.mcu.university.demo`
- 路由：`Navigation + NavPathStack`（API 26 推薦方案）

---

## 目錄結構

```
McuHarmonyOS-demo/
├── AppScope/
│   ├── app.json5                     # bundleName、版本、icon
│   └── resources/base/…
├── entry/src/main/
│   ├── module.json5                  # 無網路權限
│   ├── ets/
│   │   ├── entryability/EntryAbility.ets
│   │   ├── pages/                    # 20 個頁面（均為 NavDestination）
│   │   ├── common/
│   │   │   ├── Constants.ets         # 靜態展示資料（地標 / 電話 / 站牌）
│   │   │   ├── SessionManager.ets    # Demo 會話（無 token）
│   │   │   ├── Nav.ets               # 路由堆疊 + RouteParam 介面
│   │   │   ├── AppContext.ets        # 全域 AbilityContext 持有器
│   │   │   └── DataUtils.ets         # 寬鬆欄位提取工具
│   │   ├── model/Models.ets          # 資料模型
│   │   └── view/CommonComponents.ets # 頁首 / Loading / Empty / Error
│   └── resources/…
└── build-profile.json5 / hvigorfile.ts / oh-package.json5
```

---

## 建置

1. 使用 **DevEco Studio（API 26 SDK）** 開啟本資料夾。
2. 在 `File > Project Structure > Signing Configs` 設定簽章（或使用自動簽章）。
3. `Build > Build Hap(s)/APP(s)` 產出 HAP，或直接 Run 到模擬器 / 真機。

---

## 脫敏說明

- 無任何校方 API 端點、無 token、無帳號 / 學號資料。
- `module.json5` 未申請網路權限，程式碼無任何 HTTP / WebView 連線。
- 登入為「Demo 登入」：輸入任意帳號即建立展示用會話，不驗證、不連網。

---

## 授權與來源

本 Demo 為學術 / 展示用途。銘傳大學名稱、校徽與校園資料之權利歸屬銘傳大學所有。
