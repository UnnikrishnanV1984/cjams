import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApAcaFormRoutingModule } from './ap-aca-form-routing.module';
import { ApAcaFormComponent } from './ap-aca-form.component';
import { AdoptionModule } from '../../../../../../title4e/adoption/titleIVe-adoption.module';
import { SharedDirectivesModule } from '../../../../../../../@core/directives/shared-directives.module';
@NgModule({
  imports: [
    CommonModule,
    ApAcaFormRoutingModule,
    AdoptionModule,
    SharedDirectivesModule
  ],
  declarations: [ApAcaFormComponent]
})
export class ApAcaFormModule { }
