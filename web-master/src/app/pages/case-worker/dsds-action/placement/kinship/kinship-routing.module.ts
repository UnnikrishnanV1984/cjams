import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseApprovalComponent } from './case-approval/case-approval.component';
import { KinshipReferralComponent } from './kinship-referral/kinship-referral.component';
import { KinshipAssessmentComponent } from './kinship-assessment/kinship-assessment.component';
import { ServiceCaseComponent } from './service-case/service-case.component';
import { CaseClosureComponent } from './case-closure/case-closure.component';
import { KinshipComponent } from './kinship.component';

const routes: Routes = [{
  path: '',
  component: KinshipComponent,
  children: [
    { path: 'kinship', component: CaseApprovalComponent},
    { path: 'case-approval', component: CaseApprovalComponent },
    { path: 'kinship-referral', component: KinshipReferralComponent },
    { path: 'kinship-assessment', component: KinshipAssessmentComponent },
    { path: 'service-case', component: ServiceCaseComponent },
    { path: 'case-closure', component: CaseClosureComponent }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class KinshipRoutingModule { }
