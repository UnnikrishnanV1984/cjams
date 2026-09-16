import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinanceDashboardRoutingModule } from './finance-dashboard-routing.module';
import { WriteoffApprovalComponent } from './writeoff-approval/writeoff-approval.component';
import { FinanceDashboardComponent } from './finance-dashboard.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ConservedAcBalanceAlertComponent } from './conserved-ac-balance-alert/conserved-ac-balance-alert.component';
import { DirectorApprovalComponent } from './director-approval/director-approval.component';
import { ProgramManagerApprovalComponent } from './program-manager-approval/program-manager-approval.component';
// import { MatTooltipModule } from '@angular/material/tooltip';
import { AncillaryPaymentAdjustmentComponent } from './ancillary-payment-adjustment/ancillary-payment-adjustment.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { CommingledTransactionApprovalComponent } from './commingled-transaction-approval/commingled-transaction-approval.component';
import { DynamicModule } from 'ng-dynamic-component';
import { GridsterModule } from 'angular-gridster2';
import { SupervisorApprovalModule } from './supervisor-approval/supervisor-approval.module';
import { PurchaseAuthorizationModule } from './purchase-authorization/purchase-authorization.module';
import { ChildTransactionApprovalComponent } from './child-transaction-approval/child-transaction-approval.component';
import { ManualReceivableComponent } from './manual-receivable/manual-receivable.component';
import { ArReversalReceiptComponent } from './ar-reversal-receipt/ar-reversal-receipt.component';
import { FiscalUnitTicklersComponent } from './fiscal-unit-ticklers/fiscal-unit-ticklers.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { CfeRetainerPaymentComponent } from './cfe-retainer-payment/cfe-retainer-payment.component';
import { CustomTableModule } from '../../../shared/shared-components/custom-table/custom-table.module';
// import { SharedComponentsModule } from '../../../shared/shared-components/shared-components.module' ;//'src/app/shared/shared-components/shared-components.module';

@NgModule({
  imports: [
    CommonModule,
    FinanceDashboardRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    SortTableModule,
    // MatTooltipModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    // MatRippleModule,
    MatRadioModule,
    // MatButtonModule,
    SupervisorApprovalModule,
    PurchaseAuthorizationModule,
    SharedPipesModule,
    SharedDirectivesModule,
    GridsterModule,
    DynamicModule,
    // SharedComponentsModule,
    CustomTableModule
  ],
  declarations: [WriteoffApprovalComponent,
    FinanceDashboardComponent,
    ConservedAcBalanceAlertComponent,
    DirectorApprovalComponent,
    ProgramManagerApprovalComponent,
    AncillaryPaymentAdjustmentComponent, 
    CfeRetainerPaymentComponent,
    CommingledTransactionApprovalComponent, 
    ChildTransactionApprovalComponent, 
    ManualReceivableComponent, 
    ArReversalReceiptComponent, 
    FiscalUnitTicklersComponent]})
export class FinanceDashboardModule { }