import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AllegationActivitiesComponent } from './allegation-activities.component';

const routes: Routes = [
  {
    path: '',
    component: AllegationActivitiesComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AllegationActivitiesRoutingModule { }
