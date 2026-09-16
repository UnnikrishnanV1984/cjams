import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeSdmRoutingModule } from './intake-sdm-routing.module';
import { IntakeSdmComponent } from './intake-sdm.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    IntakeSdmRoutingModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    SharedDirectivesModule,
    PaginationModule
  ],
  declarations: [IntakeSdmComponent]
})
export class IntakeSdmModule { }
