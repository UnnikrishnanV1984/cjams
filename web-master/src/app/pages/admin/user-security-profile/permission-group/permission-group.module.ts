import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { PermissionGroupRoutingModule } from './permission-group-routing.module';
import { PermissionGroupComponent } from './permission-group.component';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
@NgModule({
    imports: [CommonModule, ReactiveFormsModule, PermissionGroupRoutingModule, FormsModule, SharedPipesModule, MatSelectModule, MatFormFieldModule],
    declarations: [PermissionGroupComponent]
})
export class PermissionGroupModule {}
