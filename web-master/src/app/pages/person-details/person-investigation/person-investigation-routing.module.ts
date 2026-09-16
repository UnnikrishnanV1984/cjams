import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonInvestigationComponent } from './person-investigation.component';

const routes: Routes = [{
  path: '',
  component: PersonInvestigationComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonInvestigationRoutingModule { }
