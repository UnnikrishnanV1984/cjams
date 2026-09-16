import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { DaConfigSharedModule } from '../../_da-config-shared/da-config-shared.module';
import { AddEditAllegationMappingComponent } from './add-edit-allegation-mapping.component';
import { AllegationMappingsRoutingModule } from './allegation-mappings-routing.module';
import { AllegationMappingsComponent } from './allegation-mappings.component';

@NgModule({
    imports: [
        CommonModule,
        AllegationMappingsRoutingModule,
        DaConfigSharedModule,
        ControlMessagesModule,
        FormsModule,
        ReactiveFormsModule,
        SharedPipesModule,
        NgSelectModule,
        SharedDirectivesModule,
        PaginationModule
    ],
    declarations: [AllegationMappingsComponent, AddEditAllegationMappingComponent]
})
export class AllegationMappingsModule {}
