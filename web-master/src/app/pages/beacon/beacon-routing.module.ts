import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BeaconComponent } from './beacon.component';


const routes: Routes = [
  {
    path: '',
    component: BeaconComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BeaconRoutingModule { }
