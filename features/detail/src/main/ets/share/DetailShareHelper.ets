import { PlatformPriceEntry, ProductSharePayload } from '@ohos/commons';

/**
 * Helper to build product share payload from detail page data.
 */
export class DetailShareHelper {
  /**
   * Build a product share payload with current product information.
   */
  static buildProductPayload(): string {
    const platformPrices: PlatformPriceEntry[] = [
      new PlatformPriceEntry('京东', '￥12899'),
      new PlatformPriceEntry('淘宝', '￥12999'),
      new PlatformPriceEntry('拼多多', '￥12849'),
      new PlatformPriceEntry('苏宁', '￥13199'),
      new PlatformPriceEntry('华为商城', '￥12999')
    ];

    const payload = new ProductSharePayload(
      'HUAWEI Mate X5 12GB+512GB 幻影紫',
      '￥12999',
      '￥13999',
      '华为官方旗舰店',
      platformPrices
    );

    return JSON.stringify(payload);
  }
}
