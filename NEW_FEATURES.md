# 新增功能文档

本文档描述在基础工程之上新增的三个功能模块。

---

## 一、新增功能概览

| 序号 | 功能名称 | 新增文件 | 修改文件 |
|------|----------|----------|----------|
| 1 | 多平台比价展示 | `features/detail/src/main/ets/view/PriceComparison.ets` | `features/detail/Index.ets`, `features/detail/src/main/ets/view/ProductDetail.ets` |
| 2 | 商品搜索功能 | `features/home/src/main/ets/view/SearchView.ets` | `features/home/Index.ets`, `features/home/src/main/ets/view/HomeHeader.ets`, `products/phone/src/main/ets/pages/Index.ets` |
| 3 | 我的页面（收藏夹与浏览历史） | `features/home/src/main/ets/view/MineContent.ets` | `features/home/Index.ets`, `features/home/src/main/ets/view/Home.ets` |

---

## 二、功能详细说明

### 2.1 多平台比价展示

**功能描述**：在商品详情页新增比价卡片，展示同一商品在京东、淘宝、拼多多、苏宁、华为商城五个平台的实时价格对比。最低价平台以红色高亮标注，并带有"最低价"标签。

**技术实现**：
- 新建 `PriceComparison` 组件，插入到 `ProductDetail.ets` 的 `ProductInfo` 结构中
- 提供5个平台的比价数据，以列表形式展示
- 最低价自动识别并通过红色主题色突出显示
- 每个平台展示平台名称、价格、"去看看"按钮
- 底部包含价格说明提示

**使用场景**：
1. 用户进入商品详情页（点击分类页商品图片）
2. 在商品价格和规格选择下方查看"多平台比价"卡片
3. 用户可一键识别各平台最低价

**展示位置**：商品详情页 > 商品规格选择下方 > 用户评价上方

---

### 2.2 商品搜索功能

**功能描述**：实现全功能商品搜索页面，支持实时关键词搜索过滤、搜索历史记录、热门搜索推荐。首页点击搜索栏即可进入搜索页面。

**技术实现**：
- 新建 `SearchView` 组件，以 `NavDestination` 形式独立页面展示
- 搜索数据源包含12个常见商品的名称、价格、分类、图片信息
- 支持按商品名称和分类进行模糊搜索过滤
- 搜索历史通过 `AppStorage` 持久化，最多保留10条
- 热门搜索标签一键搜索
- 搜索结果列表展示商品图片、名称、分类、价格

**路由注册**：
- `SearchView` 通过 Navigation 路由注册，路由名为 `'searchView'`
- 首页搜索栏添加 `onClick` 事件跳转：`pageInfos.pushPathByName('searchView', undefined)`

**使用场景**：
1. 在首页点击顶部搜索栏
2. 进入搜索页面，输入关键词实时搜索
3. 可点击历史搜索词或热门搜索标签快速搜索
4. 搜索结果显示匹配的商品列表
5. 支持清空搜索历史

---

### 2.3 我的页面 — 收藏夹与浏览历史

**功能描述**：将原本空白的"我的"Tab页实现为完整的个人中心页面，包含用户头像信息区、数据统计栏、功能菜单入口，以及"收藏夹"和"浏览历史"两个切换页签。

**技术实现**：
- 新建 `MineContent` 组件，绑定到 `Home.ets` 第5个Tab
- **用户信息区**：显示用户头像、昵称、会员等级、编辑资料入口
- **数据统计栏**：展示收藏数、足迹数、订单数、优惠券数
- **功能菜单**：我的订单、收货地址、优惠券入口
- **收藏夹Tab**：展示收藏商品列表（名称、平台、价格、降价信息），支持删除收藏
- **浏览历史Tab**：展示浏览记录（名称、价格、浏览时间），支持清空记录
- 数据通过 `AppStorage` 持久化存储
- 首次使用时注入示例数据，便于演示效果

**数据结构**：
```typescript
// 收藏商品数据结构
export class FavoriteItem {
  name: string;        // 商品名称
  price: string;       // 商品价格
  platform: string;    // 来源平台
  image: Resource;     // 商品图片
  priceDrop: string;   // 降价信息（如"￥150"）
}

// 浏览历史数据结构
export class BrowsingHistoryItem {
  name: string;        // 商品名称
  price: string;       // 商品价格
  image: Resource;     // 商品图片
  viewTime: string;    // 浏览时间（如"今天 14:30"）
}
```

**使用场景**：
1. 点击底部导航栏"我的"Tab
2. 查看收藏统计和浏览足迹
3. 在"我的收藏"Tab中管理收藏商品
4. 在"浏览历史"Tab中查看和清空浏览记录

---

## 三、响应式适配

三个新功能均继承了基础工程的响应式布局机制：

- 通过 `@StorageLink('currentBreakpoint')` 监听断点变化
- 使用 `ResourceUtil.getPageColPadding()` 获取断点适配的内边距
- 组件在 SM（直板机）、MD（折叠屏）、LG（平板）下自动适配布局

---

## 四、录屏指南

### 录屏演示要点

**录屏1（基础工程）**：演示以下功能
1. 首页浏览（商品分类、推荐、福利、闪购）
2. 分类页浏览
3. 购物袋查看
4. 点击商品进入详情页
5. 商品详情页的"直播中"功能
6. 直播页面与画中画

**录屏2（新增功能）**：演示以下新增功能
1. 首页点击搜索栏 → 搜索页 → 输入关键词搜索 → 查看结果
2. 商品详情页 → 下滑查看"多平台比价"卡片（所有5个平台价格）
3. 点击"我的"Tab → 查看收藏夹和浏览历史 → 删除收藏 / 清空历史

### 操作步骤（DevEco Studio）

1. 打开 DevEco Studio，导入本项目
2. 选择模拟器设备（推荐直板机 phone 或 Mate X 折叠屏）
3. 点击 Run 按钮编译运行
4. 使用模拟器录屏功能或第三方录屏工具录制操作过程
5. 保存视频文件为 `video1.mp4`（基础工程）和 `video2.mp4`（新增功能）
