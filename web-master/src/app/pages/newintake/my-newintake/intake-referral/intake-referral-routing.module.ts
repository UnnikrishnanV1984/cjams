import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeReferralComponent } from './intake-referral.component';

const routes: Routes = [{
  path: '',
  component: IntakeReferralComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeReferralRoutingModule { }
