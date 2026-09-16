import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { OutOfHomePlacementComponent } from './out-of-home-placement.component';

const routes: Routes = [{
  path: '',
  component: OutOfHomePlacementComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class OutOfHomePlacementRoutingModule { }
