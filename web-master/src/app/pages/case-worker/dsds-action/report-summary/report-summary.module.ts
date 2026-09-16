import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReportSummaryComponent } from './report-summary.component';
import { ReportSummaryRoutingModule } from './report-summary-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { ReportSummaryResolverService } from './report-summary-resolver-service';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { CpsDocLetterModule } from '../../../../pages/newintake/my-newintake/intake-document-creator/cps-doc-letter/cps-doc-letter.module';

@NgModule({
  imports: [
    CommonModule,
    ReportSummaryRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // // A2Edatetimepicker,
    // SharedComponentsModule,
    SharedPipesModule,
    CpsDocLetterModule
  ],
  declarations: [
    ReportSummaryComponent
  ],
  providers: [ReportSummaryResolverService]
})
export class ReportSummaryModule { }