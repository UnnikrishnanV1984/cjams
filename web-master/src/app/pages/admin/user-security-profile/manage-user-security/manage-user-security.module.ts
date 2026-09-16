import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ManageUserSecurityRoutingModule } from './manage-user-security-routing.module';
import { ManageUserSecurityComponent } from './manage-user-security.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { UserProfileComponent } from './add-edit-user-security-profile/user-profile/user-profile.component';
import { RolesLoginDetailsComponent } from './add-edit-user-security-profile/roles-login-details/roles-login-details.component';
import { EquipmentComponent } from './add-edit-user-security-profile/equipment/equipment.component';
import { AddEditUserSecurityProfileComponent } from './add-edit-user-security-profile/add-edit-user-security-profile.component';
import { RolesAndPositionComponent } from './add-edit-user-security-profile/roles-and-position/roles-and-position.component';
import { MatListModule } from '@angular/material/list';
import { MatCardModule } from '@angular/material/card';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SupervisorUserComponent } from './add-edit-user-security-profile/supervisor-user/supervisor-user.component';

@NgModule({
    imports: [
        CommonModule,
        ManageUserSecurityRoutingModule,
        NgSelectModule,
        SharedPipesModule,
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
        NgxMaskDirective,
        NgxMaskPipe
        
    ],
    providers:[provideNgxMask()],
    declarations: [ManageUserSecurityComponent, UserProfileComponent, RolesLoginDetailsComponent, EquipmentComponent, AddEditUserSecurityProfileComponent, RolesAndPositionComponent, SupervisorUserComponent]
})
export class ManageUserSecurityModule { }
