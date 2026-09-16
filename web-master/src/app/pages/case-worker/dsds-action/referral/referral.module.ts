import { NgSelectModule } from '@ng-select/ng-select';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReferralComponent } from './referral.component';
import { ReferralRoutingModule } from './referral-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
@NgModule({
  imports: [
    CommonModule,
    ReferralRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    NgSelectModule
  ],
  declarations: [
    ReferralComponent
  ],
  providers: []
})
export class ReferralModule { }
