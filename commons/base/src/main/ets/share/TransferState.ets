/**
 * Transfer state enum for the share/airdrop feature.
 */
export enum TransferState {
  IDLE = 'idle',
  DISCOVERING = 'discovering',
  CONNECTING = 'connecting',
  TRANSFERRING = 'transferring',
  DONE = 'done',
  ERROR = 'error'
}
