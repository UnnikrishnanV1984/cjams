import { ModuleWithProviders, NgModule, Optional, SkipSelf } from '@angular/core';
import { CommonModule } from '@angular/common';

import { throwIfAlreadyLoaded } from './common/module-import-guard';
import { EntityModule } from './entity.module';
// import { ServiceModule } from './service.module';
import { GuardModule } from './guard.module';
import { ErrorDisplay } from './common/errorDisplay';
// import { DirectiveModule } from './directive.module';

const CORE_PROVIDERS = [
  ...(EntityModule.forRoot().providers ?? []),
  // ...(ServiceModule.forRoot().providers ?? []),
  ...(GuardModule.forRoot().providers ?? []),
  // ...(DirectiveModule.forRoot().providers ?? [])
];

@NgModule({
  imports: [
    CommonModule,
  ],
  exports: [],
  declarations: [ErrorDisplay],
})
export class CoreModule {
  constructor(@Optional() @SkipSelf() parentModule: CoreModule) {
    throwIfAlreadyLoaded(parentModule, 'CoreModule');
  }

  static forRoot(): ModuleWithProviders<CoreModule> {
    return {
      ngModule: CoreModule,
      providers: [
        ...CORE_PROVIDERS,
      ],
    };
  }
}
