import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeServiceTypeRoutingModule } from './intake-service-type-routing.module';
import { IntakeServiceTypeComponent } from './intake-service-type.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { NgSelectModule } from '@ng-select/ng-select';

@NgModule({
  imports: [
    CommonModule,
    IntakeServiceTypeRoutingModule,
    FormMaterialModule,
    NgSelectModule
  ],
  declarations: [IntakeServiceTypeComponent]
})
export class IntakeServiceTypeModule { }
