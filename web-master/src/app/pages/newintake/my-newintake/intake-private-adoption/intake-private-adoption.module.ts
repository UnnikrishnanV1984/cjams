import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakePrivateAdoptionRoutingModule } from './intake-private-adoption-routing.module';
import { IntakePrivateAdoptionComponent } from './intake-private-adoption.component';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { MatDatepickerModule } from '@angular/material/datepicker';

@NgModule({
  imports: [
    CommonModule,
    IntakePrivateAdoptionRoutingModule,
    SharedDirectivesModule,
    MatCheckboxModule,
    BsDatepickerModule,
    FormMaterialModule,
    MatDatepickerModule
  ],
  declarations: [IntakePrivateAdoptionComponent]
})
export class IntakePrivateAdoptionModule { }
