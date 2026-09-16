import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinanceArProviderDetailsRoutingModule } from './finance-ar-provider-details-routing.module';
import { FinanceArProviderDetailsComponent } from './finance-ar-provider-details.component';
import { ArProviderComponent } from './ar-provider/ar-provider.component';
import { ArProviderOverpaymentsComponent } from './ar-provider-overpayments/ar-provider-overpayments.component';
import { ArProviderPaymentPlanComponent } from './ar-provider-payment-plan/ar-provider-payment-plan.component';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';
import { NgxfUploaderService, NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { FinanceArProviderDetailsService } from './finance-ar-provider-details.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { CommonControlsModule } from '../../../../shared/modules/common-controls/common-controls.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { ArProviderDocumentsComponent } from './ar-provider-documents/ar-provider-documents.component';
import { FiscalAuditModule } from '../../fiscal-audit/fiscal-audit.module';
import { FinanceService } from '../../finance.service';

@NgModule({
  imports: [
    CommonModule,
    FinanceArProviderDetailsRoutingModule,
    CommonControlsModule,
    MatCardModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatListModule,
    MatNativeDateModule,
    MatRadioModule,
    MatSelectModule,
    MatTableModule,
    MatTabsModule,
    MatTooltipModule,
    // A2Edatetimepicker,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    SharedPipesModule,
    SharedDirectivesModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    FiscalAuditModule
  ],
  declarations: [FinanceArProviderDetailsComponent, ArProviderComponent, ArProviderOverpaymentsComponent, ArProviderPaymentPlanComponent, ArProviderDocumentsComponent],
  providers: [NgxfUploaderService, FinanceArProviderDetailsService, FinanceService]
})
export class FinanceArProviderDetailsModule { }
