import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { DaConfigSharedModule } from '../../_da-config-shared/da-config-shared.module';
import { PaMappingRoutingModule } from './pa-mapping-routing.module';
import { PaMappingComponent } from './pa-mapping.component';


@NgModule({
  imports: [
    CommonModule,
    PaMappingRoutingModule,
    DaConfigSharedModule
  ],
  declarations: [PaMappingComponent],
  exports: []
})
export class PaMappingModule { }
