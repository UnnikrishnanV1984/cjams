import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RequestedServiceComponent } from './requested-service.component';
import { RoleGuard } from '../../@core/guard';

const routes: Routes = [{
  path: '',
  component: RequestedServiceComponent,
  canActivate: [RoleGuard],
  // children: [
  //   { path: 'accountspayable', loadChildren: './accountspayable/accountspayable.module#AccountsPayableModule' },
  // ],
  data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RequestedServiceRoutingModule { }
