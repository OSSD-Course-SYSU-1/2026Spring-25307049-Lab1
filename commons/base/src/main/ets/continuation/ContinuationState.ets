/**
 * Data model for application continuation (自由流转) state.
 * Holds all state that can be transferred between devices during
 * cross-device migration.
 */
export class ContinuationState {
  /** Currently active bottom tab index (0=首页, 1=分类, 2=发现, 3=购物袋, 4=我的) */
  currentTabIndex: number;
  /** Current page identifier for Navigation route restoration */
  currentPage: string;
  /** Currently browsed product ID or name */
  browsingProductId: string;
  /** Whether live streaming is active when migrating */
  isLiveActive: boolean;
  /** Current search keyword if user is on search page */
  searchKeyword: string;
  /** Timestamp of when the continuation state was saved */
  timestamp: number;

  constructor(tabIndex: number = 0, page: string = '', productId: string = '',
    isLive: boolean = false, search: string = '') {
    this.currentTabIndex = tabIndex;
    this.currentPage = page;
    this.browsingProductId = productId;
    this.isLiveActive = isLive;
    this.searchKeyword = search;
    this.timestamp = Date.now();
  }

  /**
   * Serialize to a plain object for want parameters transfer.
   */
  toRecord(): Record<string, Object> {
    let record: Record<string, Object> = {};
    record['currentTabIndex'] = this.currentTabIndex;
    record['currentPage'] = this.currentPage;
    record['browsingProductId'] = this.browsingProductId;
    record['isLiveActive'] = this.isLiveActive;
    record['searchKeyword'] = this.searchKeyword;
    record['continuationTimestamp'] = this.timestamp;
    return record;
  }

  /**
   * Deserialize from want parameters.
   */
  static fromRecord(params: Record<string, Object>): ContinuationState {
    const state = new ContinuationState();
    if (params['currentTabIndex'] !== undefined) {
      state.currentTabIndex = params['currentTabIndex'] as number;
    }
    if (params['currentPage'] !== undefined) {
      state.currentPage = params['currentPage'] as string;
    }
    if (params['browsingProductId'] !== undefined) {
      state.browsingProductId = params['browsingProductId'] as string;
    }
    if (params['isLiveActive'] !== undefined) {
      state.isLiveActive = params['isLiveActive'] as boolean;
    }
    if (params['searchKeyword'] !== undefined) {
      state.searchKeyword = params['searchKeyword'] as string;
    }
    if (params['continuationTimestamp'] !== undefined) {
      state.timestamp = params['continuationTimestamp'] as number;
    }
    return state;
  }
}

/**
 * Key used in AppStorage for continuation state notification.
 */
export const CONTINUATION_STATE_KEY: string = 'continuationState';
