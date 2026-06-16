import { ContinuationState, CONTINUATION_STATE_KEY } from './ContinuationState';
import { hilog } from '@kit.PerformanceAnalysisKit';

/**
 * Singleton manager for application continuation (自由流转).
 * Handles saving state before migration and restoring state after migration.
 *
 * Lifecycle:
 * 1. onContinue() calls saveState() to package current app state
 * 2. On target device, onCreate()/onNewWant() calls restoreState() to retrieve it
 * 3. restoreState() stores the state in AppStorage so UI components can react
 */
export class ContinuationManager {
  private static instance: ContinuationManager | null = null;
  private currentTabIndex: number = 0;
  private currentPage: string = '';
  private browsingProductId: string = '';
  private isLiveActive: boolean = false;
  private searchKeyword: string = '';

  private constructor() {
  }

  static getInstance(): ContinuationManager {
    if (ContinuationManager.instance === null) {
      ContinuationManager.instance = new ContinuationManager();
    }
    return ContinuationManager.instance;
  }

  /**
   * Update the current local state from the UI layer.
   * Called by the main page whenever significant state changes.
   */
  updateState(tabIndex: number, page: string = '', productId: string = '',
    isLive: boolean = false, search: string = ''): void {
    this.currentTabIndex = tabIndex;
    this.currentPage = page;
    this.browsingProductId = productId;
    this.isLiveActive = isLive;
    this.searchKeyword = search;
  }

  /**
   * Build a ContinuationState snapshot from current local state.
   * Called by onContinue() in EntryAbility.
   */
  buildContinuationState(): ContinuationState {
    return new ContinuationState(
      this.currentTabIndex,
      this.currentPage,
      this.browsingProductId,
      this.isLiveActive,
      this.searchKeyword
    );
  }

  /**
   * Restore state from continuation parameters.
   * Called by onCreate() / onNewWant() in EntryAbility when launched via continuation.
   *
   * @param params Want parameters received from the source device.
   */
  restoreFromParams(params: Record<string, Object>): void {
    const state = ContinuationState.fromRecord(params);
    this.currentTabIndex = state.currentTabIndex;
    this.currentPage = state.currentPage;
    this.browsingProductId = state.browsingProductId;
    this.isLiveActive = state.isLiveActive;
    this.searchKeyword = state.searchKeyword;

    hilog.info(0x0000, 'ContinuationManager',
      `State restored - tab=${state.currentTabIndex}, page=${state.currentPage}, product=${state.browsingProductId}`);

    // Store in AppStorage so UI layer can react to it
    AppStorage.setOrCreate(CONTINUATION_STATE_KEY, state);
  }

  /**
   * Check whether the current session was launched via continuation.
   */
  isContinuationRestore(): boolean {
    return AppStorage.get<ContinuationState>(CONTINUATION_STATE_KEY) !== undefined;
  }

  /**
   * Consume and clear the continuation state from AppStorage.
   * Called by the UI layer after handling the restore.
   */
  consumeState(): ContinuationState | null {
    const state = AppStorage.get<ContinuationState>(CONTINUATION_STATE_KEY);
    if (state) {
      AppStorage.setOrCreate(CONTINUATION_STATE_KEY, undefined);
    }
    return state ?? null;
  }

  /**
   * Get the current tab index for use by onContinue().
   */
  getCurrentTabIndex(): number {
    return this.currentTabIndex;
  }

  /**
   * Get the current page name for use by onContinue().
   */
  getCurrentPage(): string {
    return this.currentPage;
  }
}
