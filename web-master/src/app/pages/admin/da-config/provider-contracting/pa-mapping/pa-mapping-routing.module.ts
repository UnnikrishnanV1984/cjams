import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PaMappingComponent } from './pa-mapping.component';


const routes: Routes = [
  {
      path: '',
      component: PaMappingComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PaMappingRoutingModule { }
