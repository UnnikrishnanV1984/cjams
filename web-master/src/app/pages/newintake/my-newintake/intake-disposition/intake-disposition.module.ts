import { NgModule,CUSTOM_ELEMENTS_SCHEMA  } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeDispositionRoutingModule } from './intake-disposition-routing.module';
// import { IntakeDispositionComponent } from './intake-disposition.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    IntakeDispositionRoutingModule,
    FormMaterialModule,
    SharedComponentsModule,
    SharedPipesModule,
    
  ],
  declarations: [],
  schemas: [ CUSTOM_ELEMENTS_SCHEMA ]
})
export class IntakeDispositionModule { }
