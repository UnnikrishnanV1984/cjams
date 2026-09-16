import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApNarrativeComponent } from './ap-narrative.component';

const routes: Routes = [{
  path: '',
  component: ApNarrativeComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApNarrativeRoutingModule { }
