import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProviderComponent } from './provider.component';
import { RoleGuard } from '../../../@core/guard';
import { DsdsProviderViewComponent } from './dsds-provider/dsds-provider-view/dsds-provider-view.component';

const routes: Routes = [
    {
        path: '',
        component: ProviderComponent,
        canActivate: [RoleGuard],
        data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] },
        children: [
            { path: 'showProviderDetails/:id', component: DsdsProviderViewComponent },
        ],
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ProviderRoutingModule { }
