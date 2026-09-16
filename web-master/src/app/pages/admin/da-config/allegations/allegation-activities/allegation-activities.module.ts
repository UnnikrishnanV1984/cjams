import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AllegationActivitiesRoutingModule } from './allegation-activities-routing.module';
import { AllegationActivitiesComponent } from './allegation-activities.component';
import { NgSelectModule } from '@ng-select/ng-select';

@NgModule({
    imports: [
        CommonModule,
        AllegationActivitiesRoutingModule,
        ControlMessagesModule,
        FormsModule,
        ReactiveFormsModule,
        PaginationModule,
        SortTableModule,
        SharedPipesModule,
        SharedDirectivesModule,
        NgSelectModule
    ],
    declarations: [AllegationActivitiesComponent]
})
export class AllegationActivitiesModule { }
