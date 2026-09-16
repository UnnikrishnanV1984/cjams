import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { AddEditDaTypeConfigComponent } from './add-edit-da-type-config.component';
import { DaTypeConfigRoutingModule } from './da-type-config-routing.module';
import { DaTypeConfigComponent } from './da-type-config.component';
import { DefaultAccessListComponent } from './default-access-list/default-access-list.component';
import { DispositionComponent } from './disposition/disposition.component';
import { DocTypeComponent } from './doc-type/doc-type.component';
import { EntityConfigComponent } from './entity-config/entity-config.component';
import { ManageAlertsComponent } from './manage-alerts/manage-alerts.component';
import { PersonRolesComponent } from './person-roles/person-roles.component';
import { UserRolesComponent } from './user-roles/user-roles.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
    imports: [
        CommonModule,
        DaTypeConfigRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        PaginationModule,
        ControlMessagesModule,
        SharedDirectivesModule,
        NgSelectModule,
        // A2Edatetimepicker,
        SharedPipesModule,
        SortTableModule,
        MatDatepickerModule,
        MatFormFieldModule
    ],
    declarations: [DaTypeConfigComponent,
        AddEditDaTypeConfigComponent,
        PersonRolesComponent,
        DispositionComponent,
        DefaultAccessListComponent,
        EntityConfigComponent,
        UserRolesComponent,
        DocTypeComponent,
        ManageAlertsComponent
    ]
})
export class DaTypeConfigModule { }
