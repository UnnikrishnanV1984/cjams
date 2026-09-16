import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonFinanceComponent } from './finance.component';

const routes: Routes = [
  {
    path: '',
    component: PersonFinanceComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonFinanceRoutingModule { }
