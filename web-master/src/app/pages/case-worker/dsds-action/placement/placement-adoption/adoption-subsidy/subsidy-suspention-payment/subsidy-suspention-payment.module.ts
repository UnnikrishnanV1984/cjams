import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SubsidySuspentionPaymentRoutingModule } from './subsidy-suspention-payment-routing.module';
import { SubsidySuspentionPaymentComponent } from './subsidy-suspention-payment.component';
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
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';
import { FinanceService } from '../../../../../../finance/finance.service';
import { FiscalAuditModule } from '../../../../../../finance/fiscal-audit/fiscal-audit.module';

@NgModule({
  imports: [
    CommonModule,
    SubsidySuspentionPaymentRoutingModule,
    MatFormFieldModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatExpansionModule,
    MatCardModule,
    MatListModule,
    MatNativeDateModule,
    MatRadioModule,
    MatTableModule,
    MatTabsModule,
    FormMaterialModule,
    FiscalAuditModule
  ],
  declarations: [SubsidySuspentionPaymentComponent],
  providers: [FinanceService]
})
export class SubsidySuspentionPaymentModule { }
