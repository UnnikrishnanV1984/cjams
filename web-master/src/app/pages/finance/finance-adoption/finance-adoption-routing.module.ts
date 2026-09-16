import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceAdoptionComponent } from './finance-adoption.component';
import { FinanceAdoptionSearchViewComponent } from './finance-adoption-search-view/finance-adoption-search-view.component';

const routes: Routes = [
  {
      path: '',
      component: FinanceAdoptionComponent,
      canActivate: [RoleGuard],
      children: [
        { path: 'showFinanceAdoptionDetails/:id', component: FinanceAdoptionSearchViewComponent }
    ],
      data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceAdoptionRoutingModule { }
