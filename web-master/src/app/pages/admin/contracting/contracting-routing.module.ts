import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ContractingComponent } from './contracting.component';

const routes: Routes = [{
  path: '',
  component: ContractingComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContractingRoutingModule { }
