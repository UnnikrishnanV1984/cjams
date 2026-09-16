import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonOtherAgenciesComponent } from './person-other-agencies.component';

const routes: Routes = [
  {
    path: '',
    component: PersonOtherAgenciesComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonOtherAgenciesRoutingModule { }
