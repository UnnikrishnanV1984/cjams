import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { AddEditDaActionTypeComponent } from './add-edit-da-action-type.component';
import { ManageDsdsActionTypeRoutingModule } from './manage-dsds-action-type-routing.module';
import { ManageDsdsActionTypeComponent } from './manage-dsds-action-type.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';

@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        ManageDsdsActionTypeRoutingModule,
        PaginationModule,
        ControlMessagesModule,
        SortTableModule,
        SharedPipesModule,
        SharedDirectivesModule
    ],
    declarations: [ManageDsdsActionTypeComponent, AddEditDaActionTypeComponent],
    exports: [ManageDsdsActionTypeComponent, PaginationModule],
    providers: []
})
export class ManageDsdsActionTypeModule { }
