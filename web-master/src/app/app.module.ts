// import {  CommonModule, HashLocationStrategy, LocationStrategy } from '@angular/common';
// import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
// // import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
// import { NgModule, CUSTOM_ELEMENTS_SCHEMA, NO_ERRORS_SCHEMA } from '@angular/core';
// import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { TimepickerModule } from 'ngx-bootstrap/timepicker';
// import { CookieService } from 'ngx-cookie-service';
// import { NgxPaginationModule } from 'ngx-pagination';

// import { CoreModule } from './@core/core.module';
// import { AppRoutingModule } from './app-routing.module';
// import { AppComponent } from './app.component';
// import { NgIdleKeepaliveModule } from '@ng-idle/keepalive';
// import { ContactlogComponent } from './contactlog/contactlog.component';
// import { UploadProgressWidgetModule } from './shared/shared-components/upload-progress-widget/upload-progress-widget.module';
// import { NoopAnimationsModule } from '@angular/platform-browser/animations';
// @NgModule({
//     imports: [
        
//         CommonModule,
//         // BrowserAnimationsModule,
//         NoopAnimationsModule,
//         AppRoutingModule,
//         TimepickerModule.forRoot(),
//         CoreModule.forRoot(),
//         FormsModule,
//         ReactiveFormsModule,
//         NgIdleKeepaliveModule.forRoot(),
//         NgxPaginationModule,
//         UploadProgressWidgetModule
//     ],
//     declarations: [AppComponent, ContactlogComponent],
//     providers: [{ provide: LocationStrategy, useClass: HashLocationStrategy }, CookieService, provideHttpClient(withInterceptorsFromDi())],
//     bootstrap: [ AppComponent ],
//     schemas: [
//         CUSTOM_ELEMENTS_SCHEMA,
//         NO_ERRORS_SCHEMA
//       ]
// })
// export class AppModule {}