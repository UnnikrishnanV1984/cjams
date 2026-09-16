import { CommonControlsModule } from './../../../../../../shared/modules/common-controls/common-controls.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdoptionSubsidyRoutingModule } from './adoption-subsidy-routing.module';
import { AdoptionSubsidyComponent } from './adoption-subsidy.component';
import { FormMaterialModule } from '../../../../../../@core/form-material.module';
import { SharedDirectivesModule } from '../../../../../../@core/directives/shared-directives.module';
@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    AdoptionSubsidyRoutingModule,
    CommonControlsModule,
    SharedDirectivesModule
  ],
  declarations: [AdoptionSubsidyComponent],
  providers: []
})
export class AdoptionSubsidyModule { }
