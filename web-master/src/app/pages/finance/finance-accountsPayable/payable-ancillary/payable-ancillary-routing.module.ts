import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PayableAncillaryComponent } from './payable-ancillary.component';

const routes: Routes = [
  {
    path: '',
    component: PayableAncillaryComponent,
    children: []
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PayableAncillaryRoutingModule { }
