import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PaymentsComponent } from './payments.component';
import { PaymentsRoutingModule } from './payments-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import {PaymentsResolverService} from './payments-resolver-service'

@NgModule({
  imports: [
    CommonModule,
    PaymentsRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
  ],
  declarations: [
    PaymentsComponent
  ],
  providers: [PaymentsResolverService]
})
export class PaymentsModule { }
