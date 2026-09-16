import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdoptionSubsidyComponent } from './adoption-subsidy.component';

const routes: Routes = [{
  path: '',
  component: AdoptionSubsidyComponent,
  children: [
    { path: 'agreement', loadChildren: () => import( './subsidy-aggrement/subsidy-aggrement.module').then(m => m.SubsidyAggrementModule) },
    { path: 'rate', loadChildren: () => import( './subsidy-rate/subsidy-rate.module').then(m => m.SubsidyRateModule) },
    { path: 'suspention-payment', loadChildren: () => import( './subsidy-suspention-payment/subsidy-suspention-payment.module').then(m => m.SubsidySuspentionPaymentModule) },
    { path: 'subsidy-download', loadChildren: () => import( './subsidy-download/subsidy-download.module').then(m => m.SubsidyDownloadModule) },
    { path: 'adoption-annual-reviews', loadChildren: () => import( './adoption-annual-reviews/adoption-annual-reviews.module').then(m => m.AdoptionAnnualReviewsModule) },
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdoptionSubsidyRoutingModule { }
