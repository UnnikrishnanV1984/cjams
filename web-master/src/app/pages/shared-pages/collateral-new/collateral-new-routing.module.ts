import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CollateralNewComponent } from './collateral-new.component';


const routes: Routes = [{
  path: '',
  component: CollateralNewComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CollateralNewRoutingModule { }
