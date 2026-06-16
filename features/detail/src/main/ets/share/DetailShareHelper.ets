import { PlatformPriceEntry, ProductSharePayload, ProductRepository } from '@ohos/commons';

/**
 * Helper to build product share payload from detail page data.
 * Uses ProductRepository for product-specific data.
 */
export class DetailShareHelper {
  /**
   * Build a product share payload with current product information.
   * @param productId Optional product ID; uses default product if not specified.
   */
  static buildProductPayload(productId?: string): string {
    const repo = ProductRepository.getInstance();
    const product = (productId && productId.length > 0) ?
      repo.getProductById(productId) : repo.getDefaultProduct();

    if (product) {
      const payload = new ProductSharePayload(
        product.name + ' [示意图]',
        product.price,
        product.originalPrice,
        product.storeName,
        product.platformPrices
      );
      return JSON.stringify(payload);
    }

    // Fallback
    const payload = new ProductSharePayload(
      'HUAWEI Mate X5 12GB+512GB 幻影紫',
      '￥12999',
      '￥13999',
      '华为官方旗舰店',
      repo.getDefaultProduct().platformPrices
    );
    return JSON.stringify(payload);
  }
}
