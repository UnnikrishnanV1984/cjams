import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../../../@core/form-material.module';

import { PersonFinanceRoutingModule } from './finance-routing.module';
import { PersonFinanceComponent } from './finance.component';
import { AddFinanceComponent } from './add-finance/add-finance.component';
import { WagesComponent } from './beacon/wages.component';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { ClaimantComponent } from './claimant/claimant.component';
import { PaymentComponent } from './payments/payments.component';
import { PaymentsViewDialogComponent  } from './payments/payments-view-dialog/payments-view-dialog.component';
import { ContactInformation } from './contact-information/contact-information.component';
import { CreateBeaconAuditService } from './shared/audit.service';
import { CustomTableModule } from '../../../../shared/shared-components/custom-table/custom-table.module';
import { AuditAccessLogsModule } from '../../../../shared/shared-components/audit-access-logs/audit-access-logs.module';

@NgModule({
  imports: [
    CommonModule,
    PersonFinanceRoutingModule,
    FormMaterialModule,
    // SharedComponentsModule,
    CustomTableModule,
    AuditAccessLogsModule
  ],
  declarations: [
    PersonFinanceComponent,
    AddFinanceComponent,
    WagesComponent,
    ClaimantComponent,
    PaymentComponent,
    ContactInformation,
    PaymentsViewDialogComponent
  ],
  providers: [
    CreateBeaconAuditService,
  ]
})
export class PersonFinanceModule { }
