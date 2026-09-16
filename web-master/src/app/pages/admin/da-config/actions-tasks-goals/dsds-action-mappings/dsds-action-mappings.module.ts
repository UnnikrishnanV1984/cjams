import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { DaConfigSharedModule } from '../../_da-config-shared/da-config-shared.module';
import { AddEditDSDSActionMappingComponent } from './add-edit-dsds-action-mapping.component';
import { DsdsActionMappingsRoutingModule } from './dsds-action-mappings-routing.module';
import { DsdsActionMappingsComponent } from './dsds-action-mappings.component';

@NgModule({
    imports: [
        CommonModule,
        DsdsActionMappingsRoutingModule,
        DaConfigSharedModule,
        ControlMessagesModule,
        FormsModule,
        ReactiveFormsModule,
        SharedPipesModule,
        NgSelectModule,
        SharedDirectivesModule,
        PaginationModule
    ],
    declarations: [DsdsActionMappingsComponent, AddEditDSDSActionMappingComponent],
    exports: []
})
export class DsdsActionMappingsModule {}
