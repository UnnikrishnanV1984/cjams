import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinancePlacementComponent } from './finance-placement.component';
import { FinancePlacementSearchViewComponent } from './finance-placement-search-view/finance-placement-search-view.component';

const routes: Routes = [
  {
      path: '',
      component: FinancePlacementComponent,
      canActivate: [RoleGuard],
      children: [
        { path: 'showFinancePlacementDetails/:id', component: FinancePlacementSearchViewComponent }
    ],
      data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinancePlacementRoutingModule { }
