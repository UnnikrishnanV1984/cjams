import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ScPlacementGapComponent } from './sc-placement-gap.component';
import { ScDisclosureChecklistComponent } from './sc-disclosure-checklist/sc-disclosure-checklist.component';
import { ScAgreementComponent } from './sc-agreement/sc-agreement.component';

const routes: Routes = [{
  path: '',
  component: ScPlacementGapComponent,
  children : [
    {
    path: 'sc-disclosure-checklist',
    component: ScDisclosureChecklistComponent
  },
  {
    path: 'sc-agreement',
    component: ScAgreementComponent
  },
  {
    path: 'sc-annual-reviews',
    component: ScDisclosureChecklistComponent
  },
  {
    path: 'sc-assignments',
    component: ScDisclosureChecklistComponent
  }
]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ScPlacementGapRoutingModule { }
