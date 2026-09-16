import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import {A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AddEditEquipmentSearchDetailComponent } from './add-edit-equipment-search-detail.component';
import { EquipmentManagementRoutingModule } from './equipment-management-routing.module';
import { EquipmentManagementComponent } from './equipment-management.component';
import { EquipmentSearchDetailComponent } from './equipment-search-detail.component';
import { EquipmentSearchComponent } from './equipment-search.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule, ReactiveFormsModule, FormsModule,
    EquipmentManagementRoutingModule, PaginationModule, 
    // A2Edatetimepicker, 
    TreeModule, ControlMessagesModule, SharedDirectivesModule,
    NgSelectModule, SharedPipesModule, SharedDirectivesModule,
    MatFormFieldModule, MatDatepickerModule
  ],
  declarations: [EquipmentManagementComponent, EquipmentSearchComponent, EquipmentSearchDetailComponent, AddEditEquipmentSearchDetailComponent]
})
export class EquipmentManagementModule { }
