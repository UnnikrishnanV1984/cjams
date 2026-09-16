import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FiscalAuditRoutingModule } from './fiscal-audit-routing.module';
import { FiscalAuditComponent } from './fiscal-audit.component';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { FormMaterialModule } from '../../../@core/form-material.module';
import { FinanceService } from '../finance.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    FiscalAuditRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    // FormMaterialModule,
    SharedPipesModule,
    PaginationModule
  ],
  declarations: [FiscalAuditComponent],
  exports: [FiscalAuditComponent],
  providers: [FinanceService]
})
export class FiscalAuditModule { }
