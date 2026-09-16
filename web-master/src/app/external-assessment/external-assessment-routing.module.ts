import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ExternalAssessmentComponent } from './external-assessment.component';

const routes: Routes = [
    {
      path: '',
      component: ExternalAssessmentComponent
  }];

  @NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
  })
export class ExternalAssessmentRoutingModule {}
