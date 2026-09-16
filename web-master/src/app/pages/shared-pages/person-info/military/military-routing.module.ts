import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MilitaryComponent  } from './military.component';
import { AddMilitaryComponent } from './add-military/add-military.component'

const routes: Routes = [
  {
    path: '',
    component: MilitaryComponent
  }
  ,
  {
    path: 'add',
    component: AddMilitaryComponent
  },
];



@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MilitaryRoutingModule { }
