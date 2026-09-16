import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinancePayableApprovalRoutingModule } from './finance-payable-approval-routing.module';
import { FinancePayableApprovalComponent } from './finance-payable-approval.component';
import { FinancialApprovalComponent } from './financial-approval/financial-approval.component';
import { PaymentApprovalComponent } from './payment-approval/payment-approval.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DirectorApprovalComponent } from './director-approval/director-approval.component';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { CustomTableModule } from '../../../../shared/shared-components/custom-table/custom-table.module';
// import { SharedComponentsModule } from './../../../../shared/shared-components/shared-components.module';

@NgModule({
  imports: [
    CommonModule,
    FinancePayableApprovalRoutingModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    MatRippleModule,
    MatRadioModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule,
    SortTableModule,
    FormMaterialModule,
    // SharedComponentsModule,
    CustomTableModule
  ],
  declarations: [FinancePayableApprovalComponent, FinancialApprovalComponent, PaymentApprovalComponent, DirectorApprovalComponent]
})
export class FinancePayableApprovalModule { }