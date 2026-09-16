import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AllegationAllegationsComponent } from './allegation-allegations.component';

const routes: Routes = [
  {
    path: '',
    component: AllegationAllegationsComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AllegationAllegationsRoutingModule { }
