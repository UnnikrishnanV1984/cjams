import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { StaffAndTeamComponent } from './staff-and-team.component';
import { RoleGuard } from '../../../@core/guard';
import { StaffAndTeamReasignComponent } from './staff-and-team-reasign/staff-and-team-reasign.component';

const routes: Routes = [
    {
        path: '',
        component: StaffAndTeamComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'reasign/:id', component: StaffAndTeamReasignComponent },
        ],
        data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] },
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class StaffAndTeamRoutingModule { }
