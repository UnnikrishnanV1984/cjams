import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LivingArrangementDetailsComponent } from './living-arrangement-details.component';
import { AddLivingArrangementComponent } from './add-living-arrangement/add-living-arrangement.component';
import { ListlivingArrangementComponent } from './list-living-arrangement/list-living-arrangement.component';

const routes: Routes = [
  {
    path: '',
    component: LivingArrangementDetailsComponent
  },
  {
    path: 'add',
    component: AddLivingArrangementComponent
  },
  {
    path: 'list',
    component: ListlivingArrangementComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LivingArrangementDetailsRoutingModule { }
