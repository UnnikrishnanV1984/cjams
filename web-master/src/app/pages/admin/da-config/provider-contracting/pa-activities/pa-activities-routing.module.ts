import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PaActivitiesComponent } from './pa-activities.component';


const routes: Routes = [
  {
      path: '',
      component: PaActivitiesComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PaActivitiesRoutingModule { }
