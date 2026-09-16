import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CaseWorkerViewAssessmentComponent } from './case-worker-view-assessment.component';
import { CaseWorkerViewAssessmentRoutingModule } from './case-worker-view-assessment-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
@NgModule({
  imports: [
    CommonModule,
    CaseWorkerViewAssessmentRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    PaginationModule
  ],
  declarations: [
    CaseWorkerViewAssessmentComponent
  ],
  providers: []
})
export class CaseWorkerViewAssessmentModule { }
