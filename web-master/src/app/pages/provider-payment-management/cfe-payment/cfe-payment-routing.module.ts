import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CfePaymentComponent } from './cfe-payment.component';

const routes: Routes = [{
  path: '',
  component: CfePaymentComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CfePaymentRoutingModule { }
