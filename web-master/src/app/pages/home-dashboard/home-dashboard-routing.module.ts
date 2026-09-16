import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../@core/guard/role.guard';
import { HomeDashboardComponent } from './home-dashboard.component';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
const dashboardpath = 'home-dashboard';
const routes: Routes = [
  {
    path: '',
    component: HomeDashboardComponent,
    canActivate: [RoleGuard],
    // resolve: {
    //   recordData: DashboardDataResolverService
    // },
    // children: [
    //   { path: dashboardpath, loadChildren: () => import( './home-dashboard.module').then(m => m.HomeDashboardModule) }
    // ],
    data: {
      title: [dashboardpath],
      desc: 'Maryland department of human services',
      screen: { current: dashboardpath, key: dashboardpath, includeMenus: true, modules: [], skip: false },
      roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] 
      }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeDashboardRoutingModule { }
