import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonClientFamilyInfoComponent } from './person-client-family-info.component';

const routes: Routes = [
  {
    path: '',
    component: PersonClientFamilyInfoComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonClientFamilyInfoRoutingModule { }
