import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementGapComponent } from './placement-gap.component';
import { DisclosureChecklistComponent } from './disclosure-checklist/disclosure-checklist.component';
import { AgreementComponent } from './agreement/agreement.component';
import { AnnualReviewsComponent } from './annual-reviews/annual-reviews.component';
import { AssignmentsComponent } from './assignments/assignments.component';
import { ApplicationComponent } from './application/application.component';
import {PlacementGapResolverService} from './placement-gap-resolver-service'
import { RateComponent } from './rate/rate.component';
import { FinalizationChecklistComponent } from './finalization-checklist/finalization-checklist.component';

const routes: Routes = [{
  path: '',
  component: PlacementGapComponent,
  // resolve: {
  //   result: PlacementGapResolverService
  // },
  children: [
    {
      path: 'disclosure-checklist', component: DisclosureChecklistComponent,
      children: [
        {
          path: 'disability',
          loadChildren: () => import( '../../../../shared-pages/person-disability/person-disability.module').then(m => m.PersonDisabilityModule)
        }
      ]
    },
    { path: 'agreement', component: AgreementComponent },
    { path: 'rate', component: RateComponent },
    { path: 'finalization-checklist', component: FinalizationChecklistComponent },
    { path: 'annual-reviews', component: AnnualReviewsComponent },
    { path: 'assignments', component: AssignmentsComponent },
    { path: 'application', component: ApplicationComponent }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PlacementGapRoutingModule { }
