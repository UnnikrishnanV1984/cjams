import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ExternalAssessmentRoutingModule } from './external-assessment-routing.module';
import { ExternalAssessmentComponent } from './external-assessment.component';

@NgModule({
  imports: [
    CommonModule,
    ExternalAssessmentRoutingModule
  ],
  declarations: [ExternalAssessmentComponent]
})
export class ExternalAssessmentModule { }
