import { Routes, RouterModule } from '@angular/router';
import { YouthTransitionPlanComponent } from './youth-transition-plan.component';
import { NgModule } from '@angular/core';
import { YtpSummaryComponent } from './ytp-summary/ytp-summary.component';
import { YtpThoughtsAndIdeasComponent } from './ytp-thoughts-and-ideas/ytp-thoughts-and-ideas.component';
import { YtpDocumentationComponent } from './ytp-documentation/ytp-documentation.component';
import { YtpSupportiveRelationshipsComponent } from './ytp-supportive-relationships/ytp-supportive-relationships.component';
import { YtpHealthComponent } from './ytp-health/ytp-health.component';
import { YtpMoneyManagementComponent } from './ytp-money-management/ytp-money-management.component';
import { YtpHousingComponent } from './ytp-housing/ytp-housing.component';
import { YtpEducationComponent } from './ytp-education/ytp-education.component';
import { YtpEmploymentComponent } from './ytp-employment/ytp-employment.component';

const routes: Routes = [{
  path:'', component: YouthTransitionPlanComponent,
  children: [
    {
        path: 'ytp-summary',
        component: YtpSummaryComponent
    },
    {
      path: 'ytp-thoughts-and-ideas',
      component: YtpThoughtsAndIdeasComponent
    },
    {
      path: 'ytp-documentation',
      component: YtpDocumentationComponent
    },
    {
      path: 'ytp-supportive-relationships',
      component: YtpSupportiveRelationshipsComponent
    },
    {
      path: 'ytp-health',
      component: YtpHealthComponent
    },
    {
      path: 'ytp-money-management',
      component: YtpMoneyManagementComponent
    },
    {
      path: 'ytp-housing',
      component: YtpHousingComponent
    },
    {
      path: 'ytp-education',
      component: YtpEducationComponent
    },
    {
      path: 'ytp-employment',
      component: YtpEmploymentComponent
    }
]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})

export class YouthTransitionPlanRoutingModule {}
