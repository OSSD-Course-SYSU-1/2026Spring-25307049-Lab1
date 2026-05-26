import { AppDataSharePayload, FavoriteShareEntry, BrowsingShareEntry } from '@ohos/commons';
import { FavoriteItem, BrowsingHistoryItem } from '../view/MineContent';

/**
 * Helper to build app data share payload from MineContent data.
 */
export class MineShareHelper {
  /**
   * Build an app data share payload containing favorites and browsing history.
   */
  static buildAppDataPayload(favorites: FavoriteItem[], browsingHistory: BrowsingHistoryItem[]): string {
    const favEntries: FavoriteShareEntry[] = [];
    for (let i = 0; i < favorites.length; i++) {
      favEntries.push(new FavoriteShareEntry(
        favorites[i].name, favorites[i].price, favorites[i].platform));
    }

    const historyEntries: BrowsingShareEntry[] = [];
    for (let i = 0; i < browsingHistory.length; i++) {
      historyEntries.push(new BrowsingShareEntry(
        browsingHistory[i].name, browsingHistory[i].price, browsingHistory[i].viewTime));
    }

    const payload = new AppDataSharePayload(favEntries, historyEntries);
    return JSON.stringify(payload);
  }
}
