import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PermissionGroupNewComponent } from './permission-group-new.component';

const routes: Routes = [
    {
        path: '',
        component: PermissionGroupNewComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PermissionGroupNewRoutingModule {}
