import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RegulationLibraryComponent } from './regulation-library.component';

const routes: Routes = [
  {
  path: '',
  component: RegulationLibraryComponent,
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RegulationLibraryRoutingModule { }
