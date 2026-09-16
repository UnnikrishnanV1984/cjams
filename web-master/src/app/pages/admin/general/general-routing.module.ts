import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../../@core/guard';
import { GeneralComponent } from './general.component';

const routes: Routes = [
    {
        path: '',
        component: GeneralComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'manage-dsds-action-type', loadChildren: () => import( './manage-dsds-action-type/manage-dsds-action-type.module').then(m => m.ManageDsdsActionTypeModule) },
            { path: 'da-status-disposition', loadChildren: () => import( './da-status-disposition/da-status-disposition.module').then(m => m.DaStatusDispositionModule) },
            { path: 'distribution-list', loadChildren: () => import( './distribution-list/distribution-list.module').then(m => m.DistributionListModule) },
            { path: 'person-configuration', loadChildren: () => import( './person-configuration/person-configuration.module').then(m => m.PersonConfigurationModule) },
            { path: 'entity-configuration', loadChildren: () => import( './entity-configuration/entity-configuration.module').then(m => m.EntityConfigurationModule) },
            { path: '', redirectTo: 'manage-dsds-action-type' }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class GeneralRoutingModule {}
