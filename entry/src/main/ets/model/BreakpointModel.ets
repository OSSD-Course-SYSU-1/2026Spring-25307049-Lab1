/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { BreakpointType } from './BreakpointType';

@ObservedV2
export class BreakpointModel {
  private static singleton_: BreakpointModel;
  @Trace currentWidthBreakpoint: string = 'sm';
  @Trace currentHeightBreakpoint: string = 'sm';
  @Trace currentGridColumn: string = '1fr 1fr';
  @Trace windowWidth: number = 0;
  @Trace windowHeight: number = 0;
  @Trace currentNavigationMode: NavigationMode = NavigationMode.Auto;

  private constructor() {
  }

  public static getInstance() {
    if (!BreakpointModel.singleton_) {
      BreakpointModel.singleton_ = new BreakpointModel();
    }
    return BreakpointModel.singleton_;
  }

  /**
   * Returns the corresponding value from the provided options based on the current width breakpoint.
   */
  public getValue<T>(sm: T, md: T, lg: T): T {
    return new BreakpointType(sm, md, lg).getValue(this.currentWidthBreakpoint);
  }
}