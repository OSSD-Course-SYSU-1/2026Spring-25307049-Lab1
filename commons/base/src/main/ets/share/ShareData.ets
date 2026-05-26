/**
 * Platform price entry for product sharing.
 */
export class PlatformPriceEntry {
  platformName: string;
  price: string;

  constructor(platformName: string, price: string) {
    this.platformName = platformName;
    this.price = price;
  }
}

/**
 * Payload for sharing a single product's information.
 */
export class ProductSharePayload {
  productName: string;
  price: string;
  originalPrice: string;
  storeName: string;
  platformPrices: PlatformPriceEntry[];

  constructor(productName: string, price: string, originalPrice: string, storeName: string,
    platformPrices: PlatformPriceEntry[]) {
    this.productName = productName;
    this.price = price;
    this.originalPrice = originalPrice;
    this.storeName = storeName;
    this.platformPrices = platformPrices;
  }
}

/**
 * A single favorite item for app data sharing.
 */
export class FavoriteShareEntry {
  name: string;
  price: string;
  platform: string;

  constructor(name: string, price: string, platform: string) {
    this.name = name;
    this.price = price;
    this.platform = platform;
  }
}

/**
 * A single browsing history item for app data sharing.
 */
export class BrowsingShareEntry {
  name: string;
  price: string;
  viewTime: string;

  constructor(name: string, price: string, viewTime: string) {
    this.name = name;
    this.price = price;
    this.viewTime = viewTime;
  }
}

/**
 * Payload for sharing app data (favorites + browsing history).
 */
export class AppDataSharePayload {
  favorites: FavoriteShareEntry[];
  browsingHistory: BrowsingShareEntry[];
  favoritesCount: number;
  historyCount: number;
  timestamp: number;

  constructor(favorites: FavoriteShareEntry[], browsingHistory: BrowsingShareEntry[]) {
    this.favorites = favorites;
    this.browsingHistory = browsingHistory;
    this.favoritesCount = favorites.length;
    this.historyCount = browsingHistory.length;
    this.timestamp = Date.now();
  }
}
