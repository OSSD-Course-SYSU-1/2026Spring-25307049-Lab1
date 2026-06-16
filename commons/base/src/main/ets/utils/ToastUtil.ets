import { promptAction } from '@kit.ArkUI';

/**
 * Unified Toast utility for providing lightweight user feedback.
 * Uses promptAction for non-intrusive bottom-of-screen messages.
 */
export class ToastUtil {
  /**
   * Show a short toast message (default 1500ms).
   */
  static show(message: string): void {
    try {
      promptAction.showToast({
        message: message,
        duration: 1500,
        bottom: '50%'
      });
    } catch (err) {
      // Toast may fail if UI context is not ready; silently ignore
    }
  }

  /**
   * Show a toast with custom duration.
   */
  static showDuration(message: string, duration: number): void {
    try {
      promptAction.showToast({
        message: message,
        duration: duration,
        bottom: '50%'
      });
    } catch (err) {
      // Toast may fail if UI context is not ready; silently ignore
    }
  }

  /**
   * Show a toast indicating a feature is under development.
   */
  static showFeaturePending(featureName: string): void {
    ToastUtil.show(featureName + '开发中，敬请期待');
  }

  /**
   * Show a toast for navigation to a category.
   */
  static showNavigateCategory(categoryName: string): void {
    ToastUtil.show('进入「' + categoryName + '」分类');
  }

  /**
   * Show a toast for a product action.
   */
  static showProductAction(action: string): void {
    ToastUtil.show(action);
  }
}
