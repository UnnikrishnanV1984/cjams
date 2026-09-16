import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { AdoptionPlanningRoutingModule } from './adoption-planning-routing.module';
import { AdoptionPlanningComponent } from './adoption-planning.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedPipesModule } from '../../../../../../@core/pipes/shared-pipes.module';
import { FormMaterialModule } from '../../../../../../@core/form-material.module';
import { FinanceService } from '../../../../../finance/finance.service';
import { FiscalAuditModule } from '../../../../../finance/fiscal-audit/fiscal-audit.module';
import { SharedDirectivesModule } from '../../../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    AdoptionPlanningRoutingModule,
    ReactiveFormsModule,
    SharedPipesModule,
    FormMaterialModule,
    FiscalAuditModule,
    SharedDirectivesModule
  ],
  declarations: [AdoptionPlanningComponent],
  providers: [FinanceService]
})
export class AdoptionPlanningModule { }
