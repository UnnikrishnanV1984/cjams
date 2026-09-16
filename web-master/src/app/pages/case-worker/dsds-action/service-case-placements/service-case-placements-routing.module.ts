import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServiceCasePlacementsComponent } from './service-case-placements.component';
import { ServiceCasePlacementsResolverService } from './service-case-placements-resolver.service';
import { PlacmentWrapperComponent } from './placment-wrapper/placment-wrapper.component';
import { LivingArrangementFormComponent } from './placment-wrapper/living-arrangement-form/living-arrangement-form.component';
import { PlacementReferralComponent } from './placment-wrapper/placement-referral/placement-referral.component';
import { PlacementListComponent } from './placement-list/placement-list.component';
import { PlacementDetailsComponent } from './placement-details/placement-details.component';

const routes: Routes = [
  {
  path: '',
  component: ServiceCasePlacementsComponent,
  resolve: {
    config: ServiceCasePlacementsResolverService
  },
  children: [
    {
      path: 'wrapper',
      component: PlacmentWrapperComponent,
      children: [
        {
          path: 'living-arrangement',
          component: LivingArrangementFormComponent,
        },
        {
          path: 'referral',
          component: PlacementReferralComponent,
        },

      ]
    },
    {
      path: 'list',
      component: PlacementListComponent
    },
    {
      path: 'details/:action',
      component: PlacementDetailsComponent
    }

  ]

}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ServiceCasePlacementsRoutingModule { }
