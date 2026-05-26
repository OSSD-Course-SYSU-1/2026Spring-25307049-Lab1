# MultiShoppingPriceComparison 工程代码文件描述

## 一、项目概述

本项目是一个基于 HarmonyOS 的多设备购物比价应用，采用"三层工程架构"（commons / features / products）实现代码复用，通过自适应布局和响应式布局，针对直板机、双折叠屏和平板等不同设备尺寸提供差异化的页面体验。同时支持画中画（PiP）模式呈现购物直播内容。

- **Bundle Name**: com.huawei.multishoppingpricecomparison
- **Target SDK**: HarmonyOS 6.0.2 (API 22)
- **Compatible SDK**: 5.0.5 (API 17)
- **支持设备**: phone（直板机）、tablet（平板）、2in1（折叠屏/PC）

---

## 二、工程目录结构（三层架构）

```
MultiShoppingPriceComparison/
├── AppScope/                          # 应用全局配置
│   ├── app.json5                      # 应用包名、版本、图标等
│   └── resources/                     # 全局资源
│       └── base/
│           ├── element/string.json    # 全局字符串
│           └── media/app_icon.png     # 应用图标
├── build-profile.json5               # 工程构建配置（模块注册、SDK版本）
├── hvigorfile.ts                      # 构建入口
├── oh-package.json5                   # 工程级包管理
├── products/                          # [产品层] 设备入口
│   └── phone/                         # 手机产品入口模块
│       ├── build-profile.json5
│       ├── oh-package.json5
│       └── src/main/
│           ├── module.json5           # 模块配置(ability声明、权限)
│           ├── ets/
│           │   ├── entryability/EntryAbility.ets  # 主Ability入口
│           │   ├── secondability/SecondAbility.ets # 分屏SecondAbility
│           │   └── pages/Index.ets                 # 应用主页面
│           └── resources/             # 产品级资源文件
├── features/                          # [特性层] 业务功能模块
│   ├── home/                          # 首页功能模块
│   │   ├── Index.ets                  # 导出：Home, DetailShoppingBagView, ClassifyConstants
│   │   └── src/main/ets/
│   │       ├── constants/             # 首页常量定义
│   │       │   ├── HomeConstants.ets      # 首页数据常量
│   │       │   ├── ClassifyConstants.ets  # 分类页数据常量
│   │       │   └── ShoppingBagConstants.ets # 购物袋常量
│   │       ├── view/                  # 首页视图组件
│   │       │   ├── Home.ets               # 首页主框架(Tabs+底部导航)
│   │       │   ├── HomeContent.ets        # 首页内容区
│   │       │   ├── HomeHeader.ets         # 首页头部(搜索栏/消息)
│   │       │   ├── Categories.ets         # 商品分类入口
│   │       │   ├── RecommendedProductView.ets # 推荐商品
│   │       │   ├── WelfareView.ets        # 福利商品
│   │       │   ├── Selection.ets          # 甄选商品
│   │       │   ├── FlashSale.ets          # 限时抢购
│   │       │   ├── ClassifyContent.ets    # 分类内容页
│   │       │   ├── ClassifyHeader.ets     # 分类页头部
│   │       │   ├── ClassifyNavdestinationPhone.ets # 分类导航
│   │       │   ├── ClassifyShopList.ets   # 分类商品列表
│   │       │   ├── ShoppingBagContent.ets # 购物袋内容
│   │       │   ├── ShoppingBagDiscounts.ets # 购物袋优惠
│   │       │   ├── ShoppingCardItem.ets   # 购物袋商品项
│   │       │   ├── ShoppingCardFoot.ets   # 购物袋底部
│   │       │   └── CommonView.ets         # 通用视图
│   │       └── viewmodel/             # 首页视图模型
│   │           ├── FooterTabViewModel.ets     # 底部Tab数据
│   │           ├── IconInfoViewModel.ets      # 图标信息
│   │           ├── RecommendedProductViewModel.ets # 推荐商品VM
│   │           ├── SectionProductsViewModel.ets   # 版块商品VM
│   │           ├── ShopListViewModel.ets      # 商品列表VM
│   │           └── ShoppingBagListViewModel.ets  # 购物袋列表VM
│   └── detail/                        # 商品详情功能模块
│       ├── Index.ets                  # 导出：ProductHome, LiveHome, ProductMoreDetail, DetailConstants
│       └── src/main/ets/
│           ├── constants/             # 详情页常量
│           │   ├── DetailConstants.ets    # 商品详情数据常量
│           │   └── LiveConstants.ets      # 直播相关数据常量
│           ├── view/                  # 详情页视图组件
│           │   ├── ProductHome.ets        # 商品详情页(SideBarContainer布局)
│           │   ├── ProductDetail.ets      # 商品图片/信息展示
│           │   ├── ProductMoreDetail.ets  # 更多商品详情
│           │   ├── ProductConfig.ets      # 商品规格选择
│           │   ├── ProductDiscount.ets    # 商品优惠信息
│           │   ├── ProductPrice.ets       # 商品价格展示
│           │   ├── ProductUtilView.ets    # 商品底部操作栏
│           │   ├── Live.ets               # 直播播放器(XComponent+AVPlayer)
│           │   ├── LiveHome.ets           # 直播页面容器
│           │   ├── LiveMaskLayer.ets      # 直播遮罩层(评论/推荐)
│           │   ├── LiverHeader.ets        # 直播头部
│           │   ├── LiveShopList.ets       # 直播商品列表
│           │   ├── ShopBag.ets            # 购物袋页面
│           │   ├── ShopBagHeader.ets      # 购物袋头部
│           │   ├── ShopList.ets           # 商品列表
│           │   ├── PayCard.ets            # 支付卡片
│           │   ├── Comment.ets            # 评论区
│           │   ├── CommentInput.ets       # 评论输入
│           │   ├── CustomerServiceView.ets # 客服咨询页
│           │   └── CommonView.ets         # 通用视图组件
│           └── viewmodel/             # 详情页视图模型
│               ├── LiveViewModel.ets      # 直播数据VM
│               ├── PayCardViewModel.ets   # 支付VM
│               └── ShopCarViewModel.ets   # 购物车VM
└── commons/                           # [公共层] 通用能力模块
    └── base/
        ├── Index.ets                  # 统一导出接口
        └── src/main/ets/
            ├── constants/
            │   ├── CommonConstants.ets     # 通用常量(百分比/设备类型/播放器状态等)
            │   └── BreakpointConstants.ets # 断点常量(sm/md/lg/栅格列数)
            └── utils/
                ├── BreakpointType.ets      # 断点泛型类(三态值获取)
                ├── WindowUtil.ets          # 窗口工具(断点更新/全屏/分屏)
                ├── DeviceScreen.ets        # 屏幕尺寸获取
                ├── AvPlayerUtil.ets        # 视频播放器封装(状态机管理)
                ├── PipWindowUtil.ets       # 画中画(PiP)窗口管理
                ├── Logger.ets              # 统一日志封装(hilog)
                └── ResourceUtil.ets        # 响应式资源管理(断点感知)
```

---

## 三、核心模块详细分析

### 3.1 products/phone — 产品入口层

#### EntryAbility.ets (`products/phone/src/main/ets/entryability/EntryAbility.ets`)
应用的**主入口 UIAbility**，负责：
- 初始化 WindowUtil 单例
- 监听窗口尺寸变化 (`windowSizeChange`) 并调用 `updateBreakpoint()` 更新断点
- 监听窗口状态变化 (`windowStatusChange`) 检测分屏模式
- 加载主页面 `pages/Index`
- 非直板机设备设置全屏显示
- 将窗口状态（宽度、断点、安全区域高度）存储到 AppStorage 中供全局使用

**关键数据流**：
```
窗口尺寸变化 → WindowUtil.updateBreakpoint(width) → AppStorage.set('currentBreakpoint', bp)
                                                       AppStorage.set('windowWidth', width)
```

#### SecondAbility.ets (`products/phone/src/main/ets/secondability/SecondAbility.ets`)
**SecondAbility** 用于分屏场景：
- 与 EntryAbility 基本相同的初始化逻辑
- 额外监听折叠状态 (`foldStatusChange`)，折叠时自动销毁自身
- 使用 `WindowUtil.getSecondInstance()` 独立的窗口实例

#### Index.ets (`products/phone/src/main/ets/pages/Index.ets`)
应用的**主页面组件**，使用 `@Entry` 装饰器：
- 基于 `Navigation` + `NavPathStack` 实现页面路由
- 通过 `@Builder PageMap()` 注册三个页面路由：LiveHome、ProductMoreDetail、ProductHome
- 分屏模式下自动打开 ProductHome 页面

---

### 3.2 features/home — 首页功能模块

#### 架构设计
首页采用 **Tabs + TabContent** 架构，5个Tab分别是：首页、分类、发现、购物袋、我的。

#### 关键组件

| 组件 | 文件 | 功能 |
|------|------|------|
| **Home** | `view/Home.ets` | 首页主框架，Tabs容器 + 底部TabBar |
| **HomeContent** | `view/HomeContent.ets` | 首页滚动内容区，组合所有首页子组件 |
| **HomeHeader** | `view/HomeHeader.ets` | 首页头部：搜索栏 + 扫码/消息图标 |
| **Categories** | `view/Categories.ets` | 10个商品分类入口（Grid布局） |
| **RecommendedProductView** | `view/RecommendedProductView.ets` | 推荐商品区（大图卡片 + 直播标记） |
| **WelfareView** | `view/WelfareView.ets` | 福利商品（GridRow响应式网格） |
| **Selection** | `view/Selection.ets` | 甄选商品（大图卡片） |
| **FlashSale** | `view/FlashSale.ets` | 限时抢购（横向滚动列表） |
| **ClassifyContent** | `view/ClassifyContent.ets` | 分类页内容（Swiper轮播 + 商品矩阵） |
| **ShoppingBagContent** | `view/ShoppingBagContent.ets` | 购物袋列表 + 推荐商品 |

#### 响应式布局实现
- **SM（直板机）**：单列布局，横向滚动
- **MD（折叠屏）**：双列布局
- **LG（平板/PC）**：左侧Tab垂直排列，多列栅格布局

通过 `@StorageLink('currentBreakpoint')` 实现断点感知，各组件根据断点值动态调整布局参数。

---

### 3.3 features/detail — 商品详情功能模块

#### 架构设计
详情模块包含三个主要页面：**商品详情页**、**直播页**、**更多详情页**。

#### 关键组件

| 组件 | 文件 | 功能 |
|------|------|------|
| **ProductHome** | `view/ProductHome.ets` | 商品详情主页面，SideBarContainer 实现侧边栏评论 |
| **ProductDetail** | `view/ProductDetail.ets` | 商品图片轮播 + 商品信息展示 |
| **ProductConfig** | `view/ProductConfig.ets` | 商品规格选择（颜色/容量/类型） |
| **ProductPrice** | `view/ProductPrice.ets` | 商品价格 + 限时优惠倒计时 |
| **ProductUtilView** | `view/ProductUtilView.ets` | 底部操作栏（客服/购物袋/加入购物车/购买） |
| **Live** | `view/Live.ets` | 直播播放器（XComponent + AVPlayer） |
| **LiveHome** | `view/LiveHome.ets` | 直播页面（播放器 + 商品列表/购物袋/支付） |
| **LiveMaskLayer** | `view/LiveMaskLayer.ets` | 直播遮罩（评论滚动 + 推荐商品） |
| **ShopBag** | `view/ShopBag.ets` | 购物袋（商品列表 + Tab筛选） |
| **PayCard** | `view/PayCard.ets` | 支付卡片（地址/配送/支付方式） |
| **Comment** | `view/Comment.ets` | 商品评论区 |
| **CustomerServiceView** | `view/CustomerServiceView.ets` | 客服咨询页面 |

#### 画中画（PiP）实现
- `PipWindowUtil` 封装了 HarmonyOS PiP API
- 通过 `PiPWindow.create()` 创建 PiP 控制器
- 支持 `startPiP()` / `stopPiP()` 进入/退出画中画
- 监听 `stateChange` 和 `controlPanelActionEvent` 事件
- 画中画窗口使用 XComponent 继续渲染视频内容

#### 分屏比价实现
- 在 LG 断点下，商品详情页右上角显示分屏按钮
- 点击按钮启动 SecondAbility，以 `WINDOW_MODE_SPLIT_PRIMARY` 分屏模式展示
- 主次窗口各自独立展示商品详情，实现"分屏比价"

#### 页面间交互流程
```
首页 → 点击分类商品 → ProductHome (商品详情)
  ├── 点击"聊天" → CustomerServiceView (客服)
  ├── 点击"购物袋" → ShopBag → PayCard (支付)
  ├── 点击"购买" → PayCard (支付)
  └── 点击"直播中" → LiveHome (直播)
        ├── 点击关闭按钮 → 画中画模式 (PiP)
        ├── 点击推荐商品 → LiveHome内嵌 ProductDetail
        ├── 点击购物袋 → ShopBag → PayCard
        └── 底部评论输入区
```

---

### 3.4 commons/base — 公共基础模块

#### 常量定义

| 文件 | 主要内容 |
|------|----------|
| **CommonConstants.ets** | 全局百分比、字体权重、设备类型、AVPlayer状态枚举、视频文件名等 |
| **BreakpointConstants.ets** | SM/MD/LG 断点标识、栅格列数 `[4,8,12]`、断点阈值 `[320,600,840]` |

#### 工具类

| 工具类 | 核心功能 |
|--------|----------|
| **WindowUtil** | 单例模式，管理窗口实例；`updateBreakpoint()` 根据窗口宽度计算断点（<600=sm, <840=md, ≥840=lg）；`updateWindowStatusType()` 检测分屏状态 |
| **BreakpointType\<T\>** | 泛型断点容器，存储 sm/md/lg 三态值，`getValue(currentBreakpoint)` 根据当前断点返回对应值 |
| **DeviceScreen** | 获取设备屏幕宽高（px→vp 转换） |
| **AvPlayerUtil** | AVPlayer 封装，管理播放器状态机（idle→initialized→prepared→playing）；支持 `play()`/`pause()`/`release()` 控制 |
| **PipWindowUtil** | 画中画功能封装，管理 PiP 生命周期和控制器 |
| **Logger** | 基于 hilog 的统一日志工具 |
| **ResourceUtil** | 响应式资源管理，通过 BreakpointType 存储不同断点下的资源值（颜色/尺寸/间距等） |

#### 响应式布局核心机制

```
窗口尺寸变化
    ↓
WindowUtil.updateBreakpoint(width)
    ↓
AppStorage.set('currentBreakpoint', 'sm'|'md'|'lg')
    ↓
各组件 @StorageLink('currentBreakpoint') 自动更新
    ↓
BreakpointType.getValue(currentBreakpoint) 返回适配值
    ↓
组件使用 GridRow/GridCol 等响应式容器重排布局
```

**断点定义**：
- SM (Small): 320–599 vp → 4列栅格 → 直板机
- MD (Medium): 600–839 vp → 8列栅格 → 折叠屏
- LG (Large): ≥840 vp → 12列栅格 → 平板/PC

---

## 四、关键技术点总结

1. **三层工程架构**：commons（公共能力） → features（业务功能） → products（设备入口），实现最大化代码复用
2. **响应式布局**：基于断点系统（BreakpointConstants + BreakpointType），组件根据 `currentBreakpoint` 动态调整布局
3. **自适应布局**：使用 GridRow/GridCol 栅格系统、SideBarContainer、Tabs 等自适应容器
4. **画中画**：利用 HarmonyOS PiP API 实现直播视频的画中画播放
5. **分屏比价**：通过 SecondAbility + WINDOW_MODE_SPLIT_PRIMARY 实现分屏模式
6. **状态管理**：基于 AppStorage 的全局状态共享，通过 `@StorageLink` 实现组件间数据同步
7. **视频播放**：基于 AVPlayer + XComponent 实现直播视频播放，完整的状态机管理
