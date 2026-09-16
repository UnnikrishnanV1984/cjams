import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonProbationComponent } from './person-probation.component';

const routes: Routes = [
  {
    path: '',
    component: PersonProbationComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonProbationRoutingModule { }
