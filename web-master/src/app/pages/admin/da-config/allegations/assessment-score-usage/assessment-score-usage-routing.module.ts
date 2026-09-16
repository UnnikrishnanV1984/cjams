import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AssessmentScoreUsageComponent } from './assessment-score-usage.component';

const routes: Routes = [
  {
    path: '',
    component: AssessmentScoreUsageComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AssessmentScoreUsageRoutingModule { }
