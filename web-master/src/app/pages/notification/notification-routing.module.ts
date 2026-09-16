import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../@core/guard';
import { NotificationComponent } from './notification.component';

const routes: Routes = [
    {
        path: '',
        component: NotificationComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'notification', loadChildren: () => import( './notification.module').then(m => m.NotificationModule) }
        ],
        data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class NotificationRoutingModule { }
