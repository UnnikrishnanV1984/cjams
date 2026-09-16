import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseWorkerComponent } from './case-worker.component';
import { FormLetterComponent } from './form-letter/form-letter.component';
import { RoutingComponent } from './routing/routing.component';
import { NotificationComponent } from './notification/notification.component';
import { DashboardComponent } from './dashboard.component';
import { CaseWorkerResolverService } from './case-worker-resolver.service';
import { RoleGuard } from '../../@core/guard';

const routes: Routes = [
    {
        path: '',
        component: DashboardComponent,
        data: {
            title: ['MDTHINK - Case worker'],
            desc: 'Maryland department of human services',
            screen: { current: 'caseworker', modules: [], skip: false }
        }
    },
    {
        path: ':id/:daNumber',
        component: CaseWorkerComponent,
        canActivate: [RoleGuard],
        canActivateChild: [RoleGuard],
        children: [
            {
                path: '',
                redirectTo: 'dsds-action',
                pathMatch: 'full'
            },
            {
                path: 'dsds-action',
                loadChildren: () => import(
                    './dsds-action/dsds-action.module').then(m => m.DsdsActionModule)
            },
            { path: 'form-letter', component: FormLetterComponent },
            { path: 'routing', component: RoutingComponent },
            { path: 'notification', component: NotificationComponent }
        ],
        data: {
            title: ['MDTHINK - Case worker'],
            desc: 'Maryland department of human services',
            screen: { current: 'caseworker', modules: [], skip: false }
            // screen: { current: 'caseworker', key: 'cw-module', includeMenus: true,  modules: [], skip: false }
        },
        resolve: {
            intakesummary: CaseWorkerResolverService
        }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class CaseWorkerRoutingModule {}
