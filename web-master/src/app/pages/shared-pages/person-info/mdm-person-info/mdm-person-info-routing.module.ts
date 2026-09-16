import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MdmPersonInfoComponent } from './mdm-person-info.component';

const routes: Routes = [
  {
    path: '',
    component: MdmPersonInfoComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MdmPersonInfoRoutingModule { }
