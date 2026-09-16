import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AllegationGoalsRoutingModule } from './allegation-goals-routing.module';
import { AllegationGoalsComponent } from './allegation-goals.component';

@NgModule({
    imports: [
        CommonModule,
        AllegationGoalsRoutingModule,
        ControlMessagesModule,
        PaginationModule,
        FormsModule,
        ReactiveFormsModule,
        SortTableModule,
        SharedDirectivesModule,
        SharedPipesModule
    ],
    declarations: [AllegationGoalsComponent]
})
export class AllegationGoalsModule { }
