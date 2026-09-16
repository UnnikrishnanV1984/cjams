import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { KinshipComponent } from './kinship.component';
import { KinshipRoutingModule } from './kinship-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';

@NgModule({
  imports: [
    CommonModule,
    KinshipRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot()
  ],
  declarations: [
    KinshipComponent
  ],
  providers: []
})
export class KinshipModule { }
