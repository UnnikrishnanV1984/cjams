import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApEmotionalTilesComponent } from './ap-emotional-tiles.component';

const routes: Routes = [{
  path: '',
  component: ApEmotionalTilesComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApEmotionalTilesRoutingModule { }
