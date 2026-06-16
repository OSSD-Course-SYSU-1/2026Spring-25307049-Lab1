# 比价比货 — 多设备购物比价应用

### 简介

本应用基于 HarmonyOS 自适应布局和响应式布局，实现**一次开发，多端部署**的购物比价平台。通过"三层工程架构"实现代码复用，根据手机、折叠屏、平板及 PC/2in1 不同设备尺寸自动适配 UI 布局。

核心功能包括：多平台比价、商品搜索、购物车、直播（画中画）、**自由流转（跨设备迁移）** 和 **隔空投送（跨设备分享）**。

---

## 运行效果

| 直板机 | 折叠屏 (Mate X) | 平板 |
|--------|----------------|------|
| ![](screenshots/device/phone.png) | ![](screenshots/device/foldable.png) | ![](screenshots/device/tablet.png) |

---

## 三大核心功能

### 一、一次开发多端部署

基于自适应 + 响应式布局，一套代码适配多设备形态。

| 特性 | 实现方式 |
|------|----------|
| **三级断点系统** | SM（320–599vp，4 列网格）、MD（600–839vp，8 列）、LG（≥840vp，12 列） |
| **泛型断点类型** | `BreakpointType<T>` 根据当前断点返回 sm/md/lg 对应值 |
| **栅格布局** | 5 个视图使用 `GridRow`/`GridCol`，17 个视图中 16 个消费 `currentBreakpoint` |
| **设备类型覆盖** | `phone`、`tablet`、`2in1`（折叠屏） |
| **折叠屏适配** | 实时监听 `foldStatusChange` 事件，折叠时自动调整布局 |
| **分屏比价** | LG 断点下启用 SideBarContainer + SecondAbility 实现并排商品比较 |

**架构层次：**

```
AppScope/                  ← 应用入口 + 图标资源
products/phone/            ← 产品层（EntryAbility + 页面路由）
features/home/             ← 首页业务层（5 个标签页）
features/detail/           ← 详情业务层（商品详情 + 直播）
commons/base/              ← 公共层（工具、数据、断点、共享、流转）
```

---

### 二、自由流转（跨设备迁移）

用户在一台设备上浏览商品或搜索时，可无缝切换至另一台设备继续操作，**状态完整保留**。

| 环节 | 实现 |
|------|------|
| **状态捕获** | 5 个 UI 页面实时调用 `ContinuationManager.updateState()` 上报状态 |
| **状态打包** | `EntryAbility.onContinue()` 序列化 `ContinuationState` 并通过 Want 传输 |
| **状态恢复** | 目标设备 `onCreate()`/`onNewWant()` 反序列化后通过 `NavPathStack` 导航至原页面 |
| **恢复字段** | 标签页索引、当前页面路由、浏览商品 ID、搜索关键词、直播状态 |
| **权限配置** | `continuable: true` + `ohos.permission.DISTRIBUTED_DATASYNC` |

**流转流程：**

```
源设备                          目标设备
  │                               │
  ├─ UI更新状态 ──► ContinuationManager
  │                               │
  ├─ onContinue() ◄── 系统触发迁移
  │   └─ 打包 5 个字段到 Want
  │                               │
  │   ──── Want 传输 ────────►  │
  │                               │
  │                        onCreate()/onNewWant()
  │                           └─ restoreFromParams()
  │                               │
  │                        Index.ets aboutToAppear()
  │                           ├─ 恢复标签页 → Home.ets
  │                           ├─ 设置 CURRENT_PRODUCT_ID_KEY
  │                           └─ pushPathByName() 导航
```

---

### 三、隔空投送（跨设备分享）

模拟 **AirDrop 风格**的近距离设备发现和数据传输功能，支持分享商品详情和个人数据。

| 模块 | 文件 | 职责 |
|------|------|------|
| **状态机** | `TransferState` | IDLE → DISCOVERING → CONNECTING → TRANSFERRING → DONE / ERROR |
| **设备发现** | `DeviceDiscoveryManager` | 真实 API 预留 + 模拟 3 台华为设备，8 秒超时保护 |
| **数据传输** | `DataTransferManager` | 模拟正弦波进度 + 分布式 KV 存储接口预留 |
| **会话编排** | `ShareSessionManager` | 单例协调发现与传输，最多 3 次重试 |
| **发送 UI** | `ShareSheet` | 雷达扫描动画 → 设备列表 → 环形进度 → 成功/失败/重试 |
| **接收 UI** | `ReceiveNotification` | 顶部滑入通知卡片，显示载荷预览，接收/拒绝按钮 |
| **载荷构建** | `DetailShareHelper` / `MineShareHelper` | 商品数据 / 收藏+浏览历史 JSON 序列化 |

**入口点：**

| 页面 | 触发方式 | 分享内容 |
|------|----------|----------|
| 商品详情（ProductHome） | 右上角更多按钮 | 商品名称、价格、平台比价 |
| 商品详情（ProductDetail） | 分享图标 | 同上 |
| 底部操作栏（ProductUtilView） | 分享按钮 | 同上 |
| 个人中心（MineContent） | "分享应用数据"按钮 | 收藏夹 + 浏览历史 |

**发送 → 接收完整流程：**

```
ShareSheet                          ReceiveNotification
  │                                       │
  ├─ startDiscovery()                     │
  │   └─ 雷达动画 + 设备列表               │
  │                                       │
  ├─ 用户点击设备                          │
  │   └─ sendToDevice()                   │
  │       └─ 模拟进度 0→100%              │
  │           └─ 环形进度条动画             │
  │                                       │
  ├─ DONE ──► storeReceivedData() ──► AppStorage
  │                                       │
  │                              收到数据通知（滑入卡片）
  │                              ├─ 商品预览 / 应用数据预览
  │                              ├─ 接收按钮 → 确认
  │                              └─ 拒绝按钮 → 关闭
```

---

## 项目技术分析

### 架构设计

采用 **三层工程架构**（HAR 模块化）：

| 层级 | 模块 | 类型 | 说明 |
|------|------|------|------|
| 产品层 | `products/phone` | entry | 应用入口、页面路由、Ability 生命周期 |
| 业务层 | `features/home` | har | 首页 5 标签页、搜索、个人中心 |
| 业务层 | `features/detail` | har | 商品详情、直播、比价、支付 |
| 基础层 | `commons/base` | har | 工具类、数据仓库、断点系统、共享、流转 |

### 数据流

```
ProductRepository (单例数据仓库)
  │
  ├─► Home → 推荐商品、福利、限时抢购
  ├─► SearchView → 实时搜索过滤
  ├─► ProductHome → 商品详情 + 比价
  ├─► DetailShareHelper → 商品分享载荷
  └─► MineContent → 收藏夹 + 浏览历史
```

### 状态管理

| 机制 | 用途 |
|------|------|
| `AppStorage` | 全局共享状态：断点、窗口宽度、当前商品 ID、分享数据 |
| `@StorageLink` | 组件双向绑定 AppStorage 键值 |
| `@Provide/@Consume` | 父子组件间传递 `NavPathStack` |
| `@State` | 组件内部状态 |
| `ContinuationManager` | 跨设备迁移状态缓存 |

### 关键 API 使用

| API | 用途 |
|-----|------|
| `@kit.ArkUI` (Navigation + NavPathStack) | 声明式页面路由 |
| `@kit.AbilityKit` (UIAbility, Want) | 应用生命周期 + 自由流转 |
| `display.on('foldStatusChange')` | 折叠屏状态监听 |
| `PiPWindow` | 画中画直播 |
| `@kit.BasicServicesKit` (deviceInfo) | 设备类型检测 |
| `@kit.DistributedServiceKit` (预留) | 真实分布式设备发现 |
| `@kit.ArkData` (预留) | 真实分布式 KV 存储传输 |

---

## 相关概念

- **一次开发，多端部署**：一套代码工程，一次开发上架，多端按需部署。通过断点系统和资源限定符适配不同设备形态。
- **自适应布局**：元素根据外部容器变化按相对关系（占比、宽高比、优先级）自动调整。
- **响应式布局**：元素根据断点、栅格、屏幕方向等自动变化，本项目使用 SM/MD/LG 三级断点。
- **自由流转**：应用状态跨设备迁移，用户切换设备时无缝继续操作。
- **隔空投送**：模拟 AirDrop，通过设备发现 + 数据传输实现近场分享。
- **GridRow / GridCol**：栅格布局组件，实现响应式网格。
- **画中画 (PiP)**：视频以小窗浮层持续播放。
- **三层工程架构**：commons（共享）+ features（业务）+ products（入口），最大化代码复用。

---

## 相关权限

| 权限 | 用途 |
|------|------|
| `ohos.permission.INTERNET` | 网络数据传输 |
| `ohos.permission.DISTRIBUTED_DATASYNC` | 分布式设备发现与数据同步（自由流转 + 隔空投送） |

---

## 使用说明

### 基础操作

1. 在直板机、折叠屏（Mate X 系列）、平板安装打开应用，不同设备呈现适配后的布局效果
2. 浏览首页推荐商品、福利商品、限时抢购
3. 底部标签页切换：分类、购物袋、个人中心
4. 点击商品进入详情页，查看**多平台比价**（京东/淘宝/拼多多/苏宁/华为商城）
5. 平板模式下点击右上角分屏按钮，并排比较商品
6. 点击"直播中"进入直播间，右上角关闭可进入**画中画**模式
7. 首页搜索栏支持实时搜索，自动保存搜索历史

### 自由流转（跨设备迁移）

1. 在设备 A 打开应用，浏览某个商品或输入搜索关键词
2. 系统触发跨设备迁移（下拉任务卡片 → 流转按钮）
3. 在设备 B 上应用自动恢复：**标签页、页面、商品、搜索词**均保持原样

### 隔空投送（跨设备分享）

1. 在商品详情页点击右上角更多按钮，或点击分享图标
2. 底部弹出**隔空投送面板**，雷达动画搜索附近设备
3. 点击目标设备，查看传输进度环
4. 传输成功后目标设备弹出**接收通知卡片**，显示商品预览
5. 个人中心点击"分享应用数据"可分享收藏和浏览记录

---

## 约束与限制

1. 支持设备：直板机、双折叠（Mate X 系列）、平板、PC/2in1
2. HarmonyOS：HarmonyOS 5.0.5 Release 及以上
3. DevEco Studio：DevEco Studio 6.0.2 Release 及以上
4. HarmonyOS SDK：HarmonyOS 6.0.2 Release SDK 及以上
5. 隔空投送的分布式通信为模拟实现，真机通信需接入 `@kit.DistributedServiceKit` 和 `@kit.ArkData` 真实 API
6. 自由流转需两台设备登录同一华为账号并开启蓝牙/WiFi
