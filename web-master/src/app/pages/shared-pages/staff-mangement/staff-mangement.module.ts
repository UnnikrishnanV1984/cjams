import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StaffMangementComponent } from './staff-mangement/staff-mangement.component';
import { StaffManagementRoutingModule } from './staff-mangement-routing.module';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatListModule } from '@angular/material/list';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective} from 'ngx-mask';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { UserProfileComponent } from './user-profile/user-profile.component';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';


@NgModule({
  imports: [
    CommonModule,
    StaffManagementRoutingModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule,
    MatFormFieldModule,
    MatInputModule,
    NgSelectModule,
    CommonModule,
    NgSelectModule,
    PaginationModule,
    NgSelectModule,
    ControlMessagesModule,
    FormsModule,
    // A2Edatetimepicker,
    ReactiveFormsModule,
    SortTableModule,
    SharedPipesModule,
    SharedDirectivesModule,
    MatListModule,
    FormMaterialModule,
    MatCardModule,
    NgxMaskDirective
    
  ],
  exports: [StaffMangementComponent, UserProfileComponent],
  declarations: [StaffMangementComponent, UserProfileComponent],
  providers: [provideNgxMask()]
})
export class StaffMangementModule { }
