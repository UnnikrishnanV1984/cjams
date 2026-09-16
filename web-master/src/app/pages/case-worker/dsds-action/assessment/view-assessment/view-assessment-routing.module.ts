import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ViewAssessmentComponent } from './view-assessment.component';
const routes: Routes = [
    {
    path: '',
    component: ViewAssessmentComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ViewAssessmentRoutingModule { }
