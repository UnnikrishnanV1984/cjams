import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { KinshipComponent } from './kinship.component';
const routes: Routes = [
    {
    path: '',
    component: KinshipComponent
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class KinshipRoutingModule { }
