import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PermissionGroupComponent } from './permission-group.component';

const routes: Routes = [
    {
        path: '',
        component: PermissionGroupComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PermissionGroupRoutingModule {}
