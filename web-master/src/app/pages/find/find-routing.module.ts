import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FindComponent } from './find.component';
import { RoleGuard } from '../../@core/guard';

const routes: Routes = [
    {
        path: '',
        component: FindComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'provider', loadChildren: () => import( './provider/provider.module').then(m => m.ProviderModule) },
            { path: 'person', loadChildren: () => import( './persons/persons.module').then(m => m.PersonsModule) },
            // { path: 'accountspayable', loadChildren: () => import( './accountspayable/accountspayable.module').then(m => m.AccountsPayableModule' },
            { path: 'dsds-actions', loadChildren: () => import( './dsds-actions/dsds-actions.module').then(m => m.DsdsActionsModule)  },
            { path: 'entities', loadChildren: () => import( './entities/entities.module').then(m => m.EntitiesModule) },
            { path: 'documents', loadChildren: () => import( './documents/documents.module').then(m => m.DocumentsModule) },
            { path: 'find-regulation-library', loadChildren: () => import( './find-regulation-library/find-regulation-library.module').then(m => m.FindRegulationLibraryModule) },
            { path: 'staff-n-team', loadChildren: () => import( './staff-and-team/staff-and-team.module').then(m => m.StaffAndTeamModule) }
        ],
        data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class FindRoutingModule { }
