import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PurchaseAuthorizationRoutingModule } from './purchase-authorization-routing.module';
import { PurchaseAuthorizationComponent } from './purchase-authorization.component';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { CustomTableModule } from '../../../../shared/shared-components/custom-table/custom-table.module';

@NgModule({
  imports: [
    CommonModule,
    PurchaseAuthorizationRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    MatTooltipModule,
    MatFormFieldModule,
    MatIconModule,
    MatButtonToggleModule,
    MatSelectModule,
    SortTableModule,
    FormMaterialModule,
    SharedPipesModule,
    // SharedComponentsModule,
    CustomTableModule
  ],
  declarations: [PurchaseAuthorizationComponent] // FundingPurchaseAuthorizationComponent, PaymentPurchaseAuthorizationComponent
})
export class PurchaseAuthorizationModule { }