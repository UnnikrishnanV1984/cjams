import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { SignificantEventsComponent } from './significant-events.component';

const routes: Routes = [
  {
    path: '',
    component: SignificantEventsComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SignificantEventsRoutingModule { }
