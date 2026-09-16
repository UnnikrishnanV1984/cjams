import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ManageUserSecurityComponent } from './manage-user-security.component';
import { AddEditUserSecurityProfileComponent } from './add-edit-user-security-profile/add-edit-user-security-profile.component';

const routes: Routes = [
    {
        path: '',
        component: ManageUserSecurityComponent,
        children: [
            {
                path: 'add-edit-user-security-profile/:id/:teamId',
                component: AddEditUserSecurityProfileComponent
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ManageUserSecurityRoutingModule {}
