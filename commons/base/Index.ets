export { BreakpointConstants } from './src/main/ets/constants/BreakpointConstants';
export { BreakpointType } from './src/main/ets/utils/BreakpointType';
export { default as Logger } from './src//main/ets/utils/Logger';
export { CommonConstants } from './src/main/ets/constants/CommonConstants';
export { ResourceUtil } from './src/main/ets/utils/ResourceUtil';
export { WindowUtil } from './src/main/ets/utils/WindowUtil';
export { DeviceScreen } from './src/main/ets/utils/DeviceScreen';
export { AvPlayerUtil } from './src/main/ets/utils/AvPlayerUtil';
export { PipWindowUtil } from './src/main/ets/utils/PipWindowUtil';
export { ToastUtil } from './src/main/ets/utils/ToastUtil';

// Product data repository
export { ProductRepository, ProductModel, CURRENT_PRODUCT_ID_KEY, resolveProductId } from './src/main/ets/data/ProductRepository';

// Share/AirDrop feature exports
export { TransferState } from './src/main/ets/share/TransferState';
export { DeviceInfo } from './src/main/ets/share/DeviceInfo';
export { ProductSharePayload, AppDataSharePayload, PlatformPriceEntry, FavoriteShareEntry, BrowsingShareEntry } from './src/main/ets/share/ShareData';
export { ShareConstants, MockDeviceEntry } from './src/main/ets/share/constants/ShareConstants';
export { ShareSessionManager, SessionStateData, DataReceivedCallback } from './src/main/ets/share/manager/ShareSessionManager';
export { ShareViewModel } from './src/main/ets/share/viewmodel/ShareViewModel';
export { ShareSheet } from './src/main/ets/share/components/ShareSheet';
export { TransferProgressView } from './src/main/ets/share/components/TransferProgressView';
export { ReceiveNotification } from './src/main/ets/share/components/ReceiveNotification';

// Continuation/Free Flow (自由流转) feature exports
export { ContinuationState, CONTINUATION_STATE_KEY } from './src/main/ets/continuation/ContinuationState';
export { ContinuationManager } from './src/main/ets/continuation/ContinuationManager';