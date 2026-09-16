import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { BatchAnnualApplicationComponent } from './batch-annual-application.component';

const routes: Routes = [
  {
    path: '',
    component: BatchAnnualApplicationComponent
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BatchAnnualApplicationRoutingModule { }
