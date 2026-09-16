import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { NonContractingTypeComponent } from './non-contracting-type.component';

const routes: Routes = [
  {
    path: '',
    component: NonContractingTypeComponent
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class NonContractingTypeRoutingModule { }
