import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementBreakthelineComponent } from './placement-breaktheline.component';

const routes: Routes = [{
  path: '',
  component: PlacementBreakthelineComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PlacementBreakthelineRoutingModule { }
