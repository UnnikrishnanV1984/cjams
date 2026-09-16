import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PaymentsComponent } from './payments.component';
import {PaymentsResolverService} from './payments-resolver-service'
const routes: Routes = [
    {
    path: '',
    component: PaymentsComponent,
    // resolve: {
    //   result: PaymentsResolverService
    // },
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PaymentsRoutingModule { }
