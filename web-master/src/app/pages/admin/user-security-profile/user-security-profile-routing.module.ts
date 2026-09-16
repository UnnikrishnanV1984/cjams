import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { UserSecurityProfileComponent } from './user-security-profile.component';

const routes: Routes = [
    {
        path: '',
        component: UserSecurityProfileComponent,
        children: [
            { path: 'permission-group', loadChildren: () => import( './permission-group/permission-group.module').then(m => m.PermissionGroupModule) },
            { path: 'resources', loadChildren: () => import( './resources/resources.module').then(m => m.ResourcesModule) },
            { path: 'manage-user-security', loadChildren: () => import( './manage-user-security/manage-user-security.module').then(m => m.ManageUserSecurityModule) },
            { path: 'user-role', loadChildren: () => import( './user-role/user-role.module').then(m => m.UserRoleModule) },
            { path: '', redirectTo: 'manage-user-security', pathMatch: 'full' },
            { path: 'resource-new', loadChildren: () => import( './resource-new/resource-new.module').then(m => m.ResourcenewModule) },
        ]
    }
];
@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class UserSecurityProfileRoutingModule {}
