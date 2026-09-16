import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LifeSkillsAssessmentComponent } from './life-skills-assessment.component';

const routes: Routes = [{
  path: '',
  component: LifeSkillsAssessmentComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LifeSkillsAssessmentRoutingModule { }
