import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DistributionListComponent } from '../distribution-list/distribution-list.component';

const routes: Routes = [
  {
      path: '',
      component: DistributionListComponent,
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})

export class DistributionListRoutingModule { }
