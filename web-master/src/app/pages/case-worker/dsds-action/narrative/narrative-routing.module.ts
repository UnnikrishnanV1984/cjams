import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NarrativeComponent } from './narrative.component';
import { NarrativeResolverService } from './narrative-resolver-service';

const routes: Routes = [
  {
      path: '',
      component: NarrativeComponent,
      // resolve: {
      //   result: NarrativeResolverService
      // }
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class NarrativeRoutingModule { }
