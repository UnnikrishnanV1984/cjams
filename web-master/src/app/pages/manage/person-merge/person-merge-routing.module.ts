import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PersonMergeComponent } from './person-merge.component';

const routes: Routes = [
  {
    path: '',
    component: PersonMergeComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonMergeRoutingModule { }
