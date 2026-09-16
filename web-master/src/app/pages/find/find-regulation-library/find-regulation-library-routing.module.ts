import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { FindRegulationLibraryComponent } from './find-regulation-library.component';

const routes: Routes = [
  {
    path: '' , component: FindRegulationLibraryComponent
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FindRegulationLibraryRoutingModule { }
