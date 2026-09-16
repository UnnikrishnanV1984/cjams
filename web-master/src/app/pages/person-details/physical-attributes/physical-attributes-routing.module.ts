import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PhysicalAttributesComponent } from './physical-attributes.component';

const routes: Routes = [{
  path: '',
  component: PhysicalAttributesComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PhysicalAttributesRoutingModule { }
