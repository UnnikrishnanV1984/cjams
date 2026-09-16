import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeEntitiesRoutingModule } from './intake-entities-routing.module';
import { IntakeEntitiesComponent } from './intake-entities.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    IntakeEntitiesRoutingModule,
    FormMaterialModule,
    PaginationModule,
    SharedDirectivesModule
  ],
  declarations: [IntakeEntitiesComponent]
})
export class IntakeEntitiesModule { }
