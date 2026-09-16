import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseWorkerViewAssessmentComponent } from './case-worker-view-assessment.component';
const routes: Routes = [
    {
    path: '',
    component: CaseWorkerViewAssessmentComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaseWorkerViewAssessmentRoutingModule { }
