import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SdmComponent } from './sdm.component';
import { SdmRoutingModule } from './sdm-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { SDMResolverService } from './sdm-resolver.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    SdmRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    PaginationModule
  ],
  declarations: [
    SdmComponent
  ],
  providers: [SDMResolverService]
})
export class SdmModule { }
