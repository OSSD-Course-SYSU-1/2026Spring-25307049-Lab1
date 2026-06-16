import { PlatformPriceEntry } from '../share/ShareData';

/**
 * Represents a single product's complete data for display in the detail page.
 */
export class ProductModel {
  id: string;
  name: string;
  price: string;
  originalPrice: string;
  storeName: string;
  category: string;
  images: Resource[];
  thumbnails: Resource[];
  colorOptions: string[];
  capacities: string[];
  platformPrices: PlatformPriceEntry[];
  description: string;

  constructor(
    id: string, name: string, price: string, originalPrice: string,
    storeName: string, category: string, images: Resource[], thumbnails: Resource[],
    colorOptions: string[], capacities: string[], platformPrices: PlatformPriceEntry[],
    description: string
  ) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.originalPrice = originalPrice;
    this.storeName = storeName;
    this.category = category;
    this.images = images;
    this.thumbnails = thumbnails;
    this.colorOptions = colorOptions;
    this.capacities = capacities;
    this.platformPrices = platformPrices;
    this.description = description;
  }
}

/**
 * Central repository for all product data in the application.
 * Maps product IDs to full ProductModel instances so that
 * every page can look up consistent product information.
 */
export class ProductRepository {
  private static instance: ProductRepository | null = null;
  private products: Map<string, ProductModel> = new Map();

  private constructor() {
    this.initProducts();
  }

  static getInstance(): ProductRepository {
    if (ProductRepository.instance === null) {
      ProductRepository.instance = new ProductRepository();
    }
    return ProductRepository.instance;
  }

  /**
   * Get a product by its unique ID.
   */
  getProductById(id: string): ProductModel | null {
    return this.products.get(id) ?? null;
  }

  /**
   * Get the default product (used when no specific product is selected).
   */
  getDefaultProduct(): ProductModel {
    return this.products.get('mate_x5')!;
  }

  /**
   * Get all products.
   */
  getAllProducts(): ProductModel[] {
    let result: ProductModel[] = [];
    this.products.forEach((value: ProductModel) => {
      result.push(value);
    });
    return result;
  }

  /**
   * Search products by name or category keyword.
   */
  search(keyword: string): ProductModel[] {
    let lower = keyword.toLowerCase();
    let result: ProductModel[] = [];
    this.products.forEach((product: ProductModel) => {
      if (product.name.toLowerCase().indexOf(lower) >= 0 ||
        product.category.indexOf(lower) >= 0) {
        result.push(product);
      }
    });
    return result;
  }

  /**
   * Get the shared image set (placeholder for products without unique images).
   */
  private defaultImages(): Resource[] {
    return [
      $r('app.media.product_detail_1'),
      $r('app.media.product_detail_2'),
      $r('app.media.product_detail_3')
    ];
  }

  private defaultThumbnails(): Resource[] {
    return [
      $r('app.media.product_small_1'),
      $r('app.media.product_small_2'),
      $r('app.media.product_small_3')
    ];
  }

  private defaultPlatformPrices(): PlatformPriceEntry[] {
    return [
      new PlatformPriceEntry('京东', '￥12899'),
      new PlatformPriceEntry('淘宝', '￥12999'),
      new PlatformPriceEntry('拼多多', '￥12849'),
      new PlatformPriceEntry('苏宁', '￥13199'),
      new PlatformPriceEntry('华为商城', '￥12999')
    ];
  }

  private initProducts(): void {
    // ── 手机类 ──
    this.addProduct(new ProductModel(
      'mate_x5', 'HUAWEI Mate X5 幻影紫', '￥12999', '￥13999',
      '华为官方旗舰店', '手机',
      this.defaultImages(), this.defaultThumbnails(),
      ['幻影紫', '羽砂黑', '羽砂白'], ['12GB+512GB', '12GB+1T'],
      this.defaultPlatformPrices(),
      'HUAWEI Mate X5 搭载昆仑玻璃，支持北斗卫星消息，超感知XMAGE影像系统。'
    ));

    this.addProduct(new ProductModel(
      'mate_60_pro', 'HUAWEI Mate 60 Pro', '￥6999', '￥7999',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_1'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      [$r('app.media.product_small_1'), $r('app.media.product_small_2'), $r('app.media.product_small_3')],
      ['雅丹黑', '白沙银', '南糯紫'], ['12GB+256GB', '12GB+512GB', '12GB+1T'],
      [new PlatformPriceEntry('京东', '￥6899'), new PlatformPriceEntry('淘宝', '￥6999'),
        new PlatformPriceEntry('拼多多', '￥6799'), new PlatformPriceEntry('苏宁', '￥7099'),
        new PlatformPriceEntry('华为商城', '￥6999')],
      'HUAWEI Mate 60 Pro 搭载麒麟9000S芯片，支持卫星通话，超可靠玄武架构。'
    ));

    this.addProduct(new ProductModel(
      'mate_60', 'HUAWEI Mate 60', '￥5999', '￥6499',
      '华为官方旗舰店', '手机',
      [$r('app.media.welfare_product_2'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['雅丹黑', '白沙银'], ['12GB+256GB'],
      this.defaultPlatformPrices(),
      'HUAWEI Mate 60 直屏旗舰，超可靠玄武架构。'
    ));

    this.addProduct(new ProductModel(
      'mate_50', 'HUAWEI Mate 50', '￥4999', '￥5499',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_4'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['冰霜银', '曜金黑', '流光紫'], ['8GB+128GB', '8GB+256GB'],
      [new PlatformPriceEntry('京东', '￥4899'), new PlatformPriceEntry('淘宝', '￥4999'),
        new PlatformPriceEntry('拼多多', '￥4799'), new PlatformPriceEntry('苏宁', '￥5099'),
        new PlatformPriceEntry('华为商城', '￥4999')],
      'HUAWEI Mate 50 搭载超光变XMAGE影像，北斗卫星消息。'
    ));

    this.addProduct(new ProductModel(
      'p60_pro', 'HUAWEI P60 Pro', '￥6988', '￥7988',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_3'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['洛可可白', '羽砂紫', '羽砂黑'], ['8GB+256GB', '12GB+512GB'],
      this.defaultPlatformPrices(),
      'HUAWEI P60 Pro 超聚光XMAGE影像，艺术感美学设计。'
    ));

    this.addProduct(new ProductModel(
      'mate_50_pro', 'HUAWEI Mate 50 Pro', '￥4999', '￥5799',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_4'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['曜金黑', '冰霜银'], ['8GB+256GB'],
      this.defaultPlatformPrices(),
      'HUAWEI Mate 50 Pro 曲面屏旗舰。'
    ));

    this.addProduct(new ProductModel(
      'mate_xs2', 'Mate Xs 2', '￥9999', '￥10999',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_2'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['雅黑', '锦白'], ['8GB+256GB'],
      this.defaultPlatformPrices(),
      'HUAWEI Mate Xs 2 超轻薄折叠屏，铰链创新设计。'
    ));

    this.addProduct(new ProductModel(
      'nova_10', 'HUAWEI nova 10', '￥2949', '￥3299',
      '华为官方旗舰店', '手机',
      [$r('app.media.flash_sale_product_4'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['10号色', '曜金黑', '普罗旺斯'], ['8GB+128GB'],
      [new PlatformPriceEntry('京东', '￥2849'), new PlatformPriceEntry('淘宝', '￥2949'),
        new PlatformPriceEntry('拼多多', '￥2749'), new PlatformPriceEntry('苏宁', '￥2999'),
        new PlatformPriceEntry('华为商城', '￥2949')],
      'HUAWEI nova 10 前置6000万追焦双摄，轻薄高颜值。'
    ));

    // ── 笔记本类 ──
    this.addProduct(new ProductModel(
      'matebook_x_pro', 'HUAWEI MateBook X Pro', '￥10999', '￥11999',
      '华为官方旗舰店', '笔记本',
      [$r('app.media.welfare_product_1'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['砚黑', '皓月银'], ['16GB+1TB', '32GB+2TB'],
      this.defaultPlatformPrices(),
      'HUAWEI MateBook X Pro 超轻薄金属机身，3.1K OLED触控屏。'
    ));

    this.addProduct(new ProductModel(
      'matebook_e_go', 'MateBook E Go', '￥4899', '￥5499',
      '华为官方旗舰店', '笔记本',
      [$r('app.media.welfare_product_6'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['星云灰', '雪域白'], ['8GB+256GB', '16GB+512GB'],
      this.defaultPlatformPrices(),
      'HUAWEI MateBook E Go 二合一笔记本，轻薄便携。'
    ));

    this.addProduct(new ProductModel(
      'matebook_14s', 'HUAWEI MateBook 14s', '￥8399', '￥8899',
      '华为官方旗舰店', '笔记本',
      [$r('app.media.welfare_product_8'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['深空灰', '皓月银'], ['16GB+512GB', '16GB+1TB'],
      this.defaultPlatformPrices(),
      'HUAWEI MateBook 14s 2.5K高刷触控屏。'
    ));

    // ── 平板类 ──
    this.addProduct(new ProductModel(
      'matepad_air', 'HUAWEI MatePad Air', '￥2599', '￥2999',
      '华为官方旗舰店', '平板',
      [$r('app.media.welfare_product_3'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['曜石黑', '羽砂白', '星河蓝'], ['8GB+128GB', '12GB+256GB'],
      this.defaultPlatformPrices(),
      'HUAWEI MatePad Air 144Hz高刷护眼屏，轻薄机身。'
    ));

    // ── 穿戴类 ──
    this.addProduct(new ProductModel(
      'watch_gt4', 'HUAWEI Watch GT 4', '￥1488', '￥1688',
      '华为官方旗舰店', '穿戴',
      [$r('app.media.welfare_product_4'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['幻夜黑', '山茶棕', '云杉绿'], ['46mm', '41mm'],
      this.defaultPlatformPrices(),
      'HUAWEI Watch GT 4 超长续航14天，专业健康管理。'
    ));

    // ── 耳机类 ──
    this.addProduct(new ProductModel(
      'freebuds_pro3', 'HUAWEI FreeBuds Pro 3', '￥1499', '￥1699',
      '华为官方旗舰店', '耳机',
      [$r('app.media.welfare_product_5'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['陶瓷白', '冰霜银', '星河蓝'], ['标准版'],
      this.defaultPlatformPrices(),
      'HUAWEI FreeBuds Pro 3 超CD级无损音质，智慧动态降噪。'
    ));

    // ── 影音类 ──
    this.addProduct(new ProductModel(
      'sound_x_new', 'Sound X NEW', '￥2499', '￥2699',
      '华为官方旗舰店', '影音',
      [$r('app.media.welfare_product_7'), $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
      this.defaultThumbnails(),
      ['星际黑', '星云白'], ['标准版'],
      this.defaultPlatformPrices(),
      'HUAWEI Sound X NEW 帝瓦雷联合设计，震撼低音。'
    ));

    // ── 福利商品 ──
    let welfareIds: string[] = ['welfare_1', 'welfare_2', 'welfare_3', 'welfare_4', 'welfare_5', 'welfare_6', 'welfare_7', 'welfare_8'];
    let welfareImages: Resource[] = [
      $r('app.media.welfare_product_1'), $r('app.media.welfare_product_2'), $r('app.media.welfare_product_3'),
      $r('app.media.welfare_product_4'), $r('app.media.welfare_product_5'), $r('app.media.welfare_product_6'),
      $r('app.media.welfare_product_7'), $r('app.media.welfare_product_8')
    ];
    let welfareNames: string[] = [
      'HUAWEI MateBook X Pro 2025', 'HUAWEI Mate 60 标准版', 'HUAWEI MatePad Air 2025',
      'HUAWEI Watch GT 4 46mm', 'HUAWEI FreeBuds Pro 3', 'MateBook E Go 2025',
      'HUAWEI Sound X 2025', 'HUAWEI MateBook 14s 2025'
    ];
    let welfarePrices: string[] = ['￥1299', '￥899', '￥599', '￥2499', '￥6988', '￥1799', '￥988', '￥6999'];

    for (let i = 0; i < welfareIds.length; i++) {
      this.products.set(welfareIds[i], new ProductModel(
        welfareIds[i], welfareNames[i] + ' [示意图]', welfarePrices[i], '',
        '福利精选店铺', '福利',
        [welfareImages[i], $r('app.media.product_detail_2'), $r('app.media.product_detail_3')],
        this.defaultThumbnails(),
        ['默认'], ['默认'],
        this.defaultPlatformPrices(),
        welfareNames[i] + ' — 限时福利价，数量有限，先到先得。'
      ));
    }
  }

  private addProduct(product: ProductModel): void {
    this.products.set(product.id, product);
  }
}

/**
 * Helper to resolve a product name/partial name to an ID for navigation.
 * Maps common display names back to repository IDs.
 */
export function resolveProductId(name: string, index?: number): string {
  let lower = name.toLowerCase();
  if (lower.indexOf('mate 60 pro') >= 0 || lower.indexOf('mate60 pro') >= 0) return 'mate_60_pro';
  if (lower.indexOf('mate 60') >= 0 || lower.indexOf('mate60') >= 0) return 'mate_60';
  if (lower.indexOf('mate x5') >= 0 || lower.indexOf('matex5') >= 0) return 'mate_x5';
  if (lower.indexOf('mate xs') >= 0 || lower.indexOf('matexs') >= 0) return 'mate_xs2';
  if (lower.indexOf('mate 50 pro') >= 0 || lower.indexOf('mate50 pro') >= 0) return 'mate_50_pro';
  if (lower.indexOf('mate 50') >= 0 || lower.indexOf('mate50') >= 0) return 'mate_50';
  if (lower.indexOf('nova') >= 0) return 'nova_10';
  if (lower.indexOf('p60') >= 0) return 'p60_pro';
  if (lower.indexOf('matebook x pro') >= 0) return 'matebook_x_pro';
  if (lower.indexOf('matebook e go') >= 0 || lower.indexOf('matebooke go') >= 0) return 'matebook_e_go';
  if (lower.indexOf('matebook 14') >= 0 || lower.indexOf('matebook14') >= 0) return 'matebook_14s';
  if (lower.indexOf('matepad') >= 0) return 'matepad_air';
  if (lower.indexOf('watch') >= 0) return 'watch_gt4';
  if (lower.indexOf('freebuds') >= 0) return 'freebuds_pro3';
  if (lower.indexOf('sound') >= 0) return 'sound_x_new';

  // Fallback: use index-based mapping for list-ordered views
  let fallbackIds: string[] = ['welfare_1', 'welfare_2', 'welfare_3', 'welfare_4', 'welfare_5', 'welfare_6', 'welfare_7', 'welfare_8'];
  if (index !== undefined && index >= 0 && index < fallbackIds.length) {
    return fallbackIds[index];
  }

  return 'mate_x5'; // default
}

/**
 * Key used in AppStorage to pass current product ID to detail page.
 */
export const CURRENT_PRODUCT_ID_KEY: string = 'currentProductId';
