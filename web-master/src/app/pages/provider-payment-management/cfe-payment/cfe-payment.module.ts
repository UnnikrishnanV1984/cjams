import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CfePaymentRoutingModule } from './cfe-payment-routing.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { MatTooltipModule } from '@angular/material/tooltip';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { CfePaymentComponent } from './cfe-payment.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { FormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({ declarations: [CfePaymentComponent], imports: [CommonModule,
        CfePaymentRoutingModule,
        FormsModule,
        FormMaterialModule,
        MatTooltipModule,
        PaginationModule.forRoot(),
        NgxMaskDirective,
        NgxMaskPipe], providers: [provideNgxMask(), provideHttpClient(withInterceptorsFromDi())] })
export class CfePaymentModule { }
