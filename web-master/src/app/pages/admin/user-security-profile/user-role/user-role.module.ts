import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserRoleRoutingModule } from './user-role-routing.module';
import { UserRoleComponent } from './user-role.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { MenuModuleFormControlModule } from '../menu-module-form-control/menu-module-form-control.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';


@NgModule({
  imports: [
    CommonModule,
    UserRoleRoutingModule,
    ReactiveFormsModule, FormsModule, MenuModuleFormControlModule, NgSelectModule, FormMaterialModule,SharedPipesModule
  ],
  declarations: [UserRoleComponent]
})
export class UserRoleModule { }
