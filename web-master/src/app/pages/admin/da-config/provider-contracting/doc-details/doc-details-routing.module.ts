import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DocDetailsComponent } from './doc-details.component';


const routes: Routes = [
  {
      path: '',
      component: DocDetailsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocDetailsRoutingModule { }
