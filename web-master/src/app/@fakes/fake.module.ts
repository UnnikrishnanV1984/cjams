import { NgModule, ModuleWithProviders } from '@angular/core';
import { CommonModule } from '@angular/common';
/* Services */
// used to create fake backend
import { fakeBackendProvider } from './_helpers/index';
import { environment } from '../../environments/environment';
const FAKES = [
  fakeBackendProvider
];

@NgModule({
  imports: [
    CommonModule,
  ],
  providers: [
    ...FAKES,
  ],
})
export class FakeServiceModule {
  static forRoot(): ModuleWithProviders<FakeServiceModule> {
    if (!environment.fakeHttpResponse) {
      return {}  as any;
    } else {
      return {
        ngModule: FakeServiceModule,
        providers: [
          ...FAKES,
        ],
      };
    }
  }
}
