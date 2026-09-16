import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApplaProcessComponent } from './appla-process.component';
import { ApplaListComponent } from './appla-list/appla-list.component';

const routes: Routes = [{
  path: '',
  component: ApplaProcessComponent,
  children: [
    { path: 'view', loadChildren: () => import( '../../assessment/case-worker-view-assessment/case-worker-view-assessment.module').then(m => m.CaseWorkerViewAssessmentModule) },
    { path: 'list', component: ApplaListComponent },
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApplaProcessRoutingModule { }
