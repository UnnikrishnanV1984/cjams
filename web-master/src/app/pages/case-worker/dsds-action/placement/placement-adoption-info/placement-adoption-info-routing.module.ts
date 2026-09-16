import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementAdoptionInfoComponent } from './placement-adoption-info.component';

const routes: Routes = [
  {
    path: '',
    component: PlacementAdoptionInfoComponent,
    children: [
      // { path: 'placement-add-edit', component: PlacementAddEditComponent },
      { path: 'adoptive-family', loadChildren: () => import( './info-adoptive-family/info-adoptive-family.module').then(m => m.InfoAdoptiveFamilyModule) },
      { path: 'disruption', loadChildren: () => import( './info-disruption/info-disruption.module').then(m => m.InfoDisruptionModule) },
      { path: 'subsidy-review', loadChildren: () => import( './info-subsidy-reviews/info-subsidy-reviews.module').then(m => m.InfoSubsidyReviewsModule) },

    ]
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PlacementAdoptionInfoRoutingModule { }
