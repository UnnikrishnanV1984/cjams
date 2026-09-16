import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MdmPersonInfoRoutingModule } from './mdm-person-info-routing.module';
import { MdmPersonInfoComponent } from './mdm-person-info.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    MdmPersonInfoRoutingModule,
    FormMaterialModule,
    SharedPipesModule
  ],
  declarations: [MdmPersonInfoComponent]
})
export class MdmPersonInfoModule { }
