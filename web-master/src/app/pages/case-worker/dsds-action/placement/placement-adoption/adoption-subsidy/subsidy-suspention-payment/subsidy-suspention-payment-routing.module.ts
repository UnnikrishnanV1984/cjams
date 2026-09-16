import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SubsidySuspentionPaymentComponent } from './subsidy-suspention-payment.component';

const routes: Routes = [{
  path: '',
  component: SubsidySuspentionPaymentComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SubsidySuspentionPaymentRoutingModule { }
