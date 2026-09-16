import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../../../@core/guard';
import { DaStatusDispositionComponent } from './da-status-disposition.component';
import { DispositionCodeComponent } from './disposition-code/disposition-code.component';
import { StatusTypeComponent } from './status-type/status-type.component';

const routes: Routes = [
    {
        path: '',
        component: DaStatusDispositionComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'status-type', component: StatusTypeComponent },
            { path: 'disposition-code', component: DispositionCodeComponent },
            { path: '', redirectTo: 'status-type', pathMatch: 'full'}
        ]
    }
];
@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DaStatusDispositionRoutingModule {}
