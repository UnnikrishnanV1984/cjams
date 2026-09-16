import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TimeLineViewDjsComponent } from './time-line-view-djs.component';
const routes: Routes = [
    {
    path: '',
    component: TimeLineViewDjsComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TimeLineViewDjsRoutingModule { }
