import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeHistoryClearanceRoutingModule } from './intake-history-clearance-routing.module';
import { IntakeHistoryClearanceComponent } from './intake-history-clearance.component';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { FormMaterialModule } from '../../../../@core/form-material.module';

@NgModule({
  imports: [
    CommonModule,
    IntakeHistoryClearanceRoutingModule,
    SharedDirectivesModule,
    MatCheckboxModule,
    BsDatepickerModule,
    FormMaterialModule
  ],
  declarations: [IntakeHistoryClearanceComponent]
})
export class IntakeHistoryClearanceModule { }
