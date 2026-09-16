import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FinanceGuardianshipComponent } from './finance-guardianship.component';
import { FinanceGuardianshipSearchViewComponent } from './finance-guardianship-search-view/finance-guardianship-search-view.component';

const routes: Routes = [
  {
      path: '',
      component: FinanceGuardianshipComponent,
      canActivate: [RoleGuard],
      children: [
        { path: 'showFinanceGuardianshipDetails/:id', component: FinanceGuardianshipSearchViewComponent }
    ],
      data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FinanceGuardianshipRoutingModule { }
