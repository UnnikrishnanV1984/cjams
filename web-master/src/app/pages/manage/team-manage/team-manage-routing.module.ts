import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TeamManageComponent } from './team-manage.component';
import { RoleGuard } from '../../../@core/guard';

const routes: Routes = [
  {
    path: '',
    component: TeamManageComponent,
    canActivate: [RoleGuard]
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TeamManageRoutingModule { }
