import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { PermissionGroupNewRoutingModule } from './permission-group-new-routing.module';
import { PermissionGroupNewComponent } from './permission-group-new.component';
@NgModule({
    imports: [CommonModule, ReactiveFormsModule, PermissionGroupNewRoutingModule, FormsModule, SharedPipesModule],
    declarations: [PermissionGroupNewComponent]
})
export class PermissionGroupNewModule {}
