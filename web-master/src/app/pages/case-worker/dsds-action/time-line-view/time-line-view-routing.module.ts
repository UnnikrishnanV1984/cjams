import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TimeLineViewComponent } from './time-line-view.component';
import { TimeLineViewResolverService } from './time-line-view-resolver-service';
const routes: Routes = [
    {
    path: '',
    component: TimeLineViewComponent,
    // resolve: {
    //   result: TimeLineViewResolverService
    //   }
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TimeLineViewRoutingModule { }
