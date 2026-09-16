// import { enableProdMode } from "@angular/core";
// import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
// import { AppModule } from "./app/app.module";
// import { environment } from "./environments/environment";

// if (environment.prodMod) {
//     enableProdMode();
//     const originalWarn = console.warn;
//     console.warn = function (...args: any[]) {
//       if (
//         args.length &&
//         typeof args[0] === 'string' &&
//         args[0].includes(
//           "It looks like you're using the disabled attribute with a reactive form directive"
//         )
//       ) {
//         return;
//       }
//       originalWarn.apply(console, args);
//     };
// }

// platformBrowserDynamic()
//   .bootstrapModule(AppModule, {
//     ngZoneEventCoalescing: true,
//     ngZoneRunCoalescing: true,
//   })
//   .catch(err => console.log(err));

import { bootstrapApplication } from '@angular/platform-browser';
import {
  provideRouter,
  withHashLocation,
  withPreloading,
  NoPreloading,
  // withEnabledNonBlockingInitialNavigation,
  // withDebugTracing
} from '@angular/router';

import { AppComponent } from './app/app.component';
import { routes } from './app/app-routing.module';
import { ErrorHandler, importProvidersFrom } from '@angular/core';
import { TimepickerModule } from 'ngx-bootstrap/timepicker';
import { NgIdleKeepaliveModule } from '@ng-idle/keepalive';
import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { AuthErrorHandler } from './app/@core/handler/auth-error.handler';
import { AuthTokenInterceptor } from './app/@core/interceptor/auth-token.interceptor';
import { JsonContentTypeHeaderInterceptor } from './app/@core/interceptor/json-content-type.interceptor';
import { PreLoaderInterceptor } from './app/@core/interceptor/pre-loader.interceptor';
import { APP_BASE_HREF } from '@angular/common';
import { provideAnimations, provideNoopAnimations } from '@angular/platform-browser/animations';
import { initNewRelic } from './newrelic';
import { config } from './environments/config';

if(config.workEnvironment === 'state' && config.enableNewRelicWebAgent) {
  initNewRelic();
}

bootstrapApplication(AppComponent, {
  providers: [
    provideRouter(
      routes,
      
      withHashLocation(), // useHash: true
      withPreloading(NoPreloading), // preloadingStrategy: NoPreloading
      // withEnabledNonBlockingInitialNavigation(), // initialNavigation: 'enabledNonBlocking'
      // withDebugTracing(),
    ),
    provideAnimations(),
    importProvidersFrom(TimepickerModule.forRoot(),NgIdleKeepaliveModule.forRoot()),
    provideHttpClient(
      withInterceptorsFromDi()
    ),

    { provide: APP_BASE_HREF, useValue: '/' },

    { provide: ErrorHandler, useClass: AuthErrorHandler },

    { provide: HTTP_INTERCEPTORS, useClass: AuthTokenInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: JsonContentTypeHeaderInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: PreLoaderInterceptor, multi: true },
  ]
}).catch(console.error);
