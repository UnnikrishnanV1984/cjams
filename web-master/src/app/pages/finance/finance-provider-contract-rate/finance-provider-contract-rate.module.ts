import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinanceProviderContractRateRoutingModule } from './finance-provider-contract-rate-routing.module';
import { FinanceProviderContractRateComponent } from './finance-provider-contract-rate.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    FinanceProviderContractRateRoutingModule,
    // FormMaterialModule,
    PaginationModule,
    MatInputModule,
    MatFormFieldModule,
    MatRadioModule,
    SharedPipesModule,
    PaginationModule
  ],
  declarations: [FinanceProviderContractRateComponent]
})
export class FinanceProviderContractRateModule { }
