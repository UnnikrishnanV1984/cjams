import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdoptionPersonsComponent } from './adoption-persons.component';

const routes: Routes = [
  {
      path: '',
      component: AdoptionPersonsComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdoptionPersonsRoutingModule { }
