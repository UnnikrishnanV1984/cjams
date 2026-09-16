import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { PaginationModule } from '../../../shared/modules/pagination/pagination.module';
import { AddEditManageDaGroupComponent } from './add-edit-manage-da-group/add-edit-manage-da-group.component';
import { ManageDaGroupRoutingModule } from './manage-da-group-routing.module';
import { ManageDaGroupComponent } from './manage-da-group.component';

@NgModule({
  imports: [
    CommonModule,
    ManageDaGroupRoutingModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    NgSelectModule,
    SharedPipesModule,
    BsDatepickerModule
  ],
  declarations: [ManageDaGroupComponent, AddEditManageDaGroupComponent],
  exports: [AddEditManageDaGroupComponent]

})
export class ManageDaGroupModule { }
