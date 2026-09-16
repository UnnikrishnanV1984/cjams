import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ApChicklistComponent } from './ap-chicklist.component';

const routes: Routes = [{
  path: '',
  component: ApChicklistComponent,
  children: []
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ApChicklistRoutingModule { }
