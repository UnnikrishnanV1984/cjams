import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementValidationsComponent } from './placement-validations.component';
import { ApprovedPlacementComponent } from './approved-placement/approved-placement.component';
import { PendingPlacementComponent } from './pending-placement/pending-placement.component';
import { PlacementValidationsResolverService } from './placement-validations-resolver-service';

const routes: Routes = [
  {
    path: '',
    component: PlacementValidationsComponent,
    // resolve: {
    //   result: PlacementValidationsResolverService
    //   },
    children: [
      {
        path: 'pending',
        component: PendingPlacementComponent
      },
      {
        path: 'approved',
        component: ApprovedPlacementComponent
      },
      {
        path: '**',
        redirectTo: 'pending'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PlacementValidationsRoutingModule { }
