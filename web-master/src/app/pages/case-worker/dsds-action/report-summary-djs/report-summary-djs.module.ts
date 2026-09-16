import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReportSummaryDjsComponent } from './report-summary-djs.component';
import { ReportSummaryDjsRoutingModule } from './report-summary-djs-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
@NgModule({
  imports: [
    CommonModule,
    ReportSummaryDjsRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
  ],
  declarations: [
    ReportSummaryDjsComponent
  ],
  providers: []
})
export class ReportSummaryDjsModule { }
