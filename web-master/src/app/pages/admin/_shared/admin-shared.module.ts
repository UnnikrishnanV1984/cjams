import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { MasterCatalogueComponent } from './master-catalogue/master-catalogue.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';

@NgModule({
    imports: [
        CommonModule,
        RouterModule,
        FormsModule,
        ReactiveFormsModule,
        PaginationModule,
        BsDatepickerModule,
        ControlMessagesModule,
        SortTableModule,
        SharedPipesModule,
        SharedDirectivesModule
    ],
    declarations: [MasterCatalogueComponent],
    exports: [MasterCatalogueComponent]
})
export class AdminSharedModule { }
