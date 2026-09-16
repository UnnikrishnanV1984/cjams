import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RecordingTypeComponent } from './recording-type.component';

const routes: Routes = [
  {
      path: '',
      component: RecordingTypeComponent
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RecordingTypeRoutingModule { }
