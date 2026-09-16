import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MaintainServiceStructuresComponent } from './maintain-service-structures.component';

const routes: Routes = [{
  path: '',
  component: MaintainServiceStructuresComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MaintainServiceStructuresRoutingModule { }
