import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeRoaRoutingModule } from './intake-roa-routing.module';
import { IntakeRoaComponent } from './intake-roa.component';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    IntakeRoaRoutingModule,
    SharedDirectivesModule,
    FormMaterialModule,
    PaginationModule
  ],
  declarations: [IntakeRoaComponent]
})
export class IntakeRoaModule { }
