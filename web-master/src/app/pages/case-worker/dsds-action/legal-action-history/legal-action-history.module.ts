import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LegalActionHistoryComponent } from './legal-action-history.component';
import { LegalActionHistoryRoutingModule } from './legal-action-history-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';

@NgModule({
  imports: [
    CommonModule,
    LegalActionHistoryRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot()
  ],
  declarations: [
    LegalActionHistoryComponent
  ],
  providers: []
})
export class LegalActionHistoryModule { }
