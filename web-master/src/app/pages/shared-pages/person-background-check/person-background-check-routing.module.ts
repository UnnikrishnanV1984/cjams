import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonBackgroundCheckComponent } from './person-background-check/person-background-check.component';

const routes: Routes = [{
  path: '', component: PersonBackgroundCheckComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonBackgroundCheckRoutingModule { }
