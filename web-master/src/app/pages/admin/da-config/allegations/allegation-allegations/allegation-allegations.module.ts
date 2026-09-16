import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { AllegationAllegationsRoutingModule } from './allegation-allegations-routing.module';
import { AllegationAllegationsComponent } from './allegation-allegations.component';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
@NgModule({
    imports: [
        CommonModule,
        RouterModule,
        FormsModule,
        ControlMessagesModule,
        ReactiveFormsModule,
        AllegationAllegationsRoutingModule,
        PaginationModule,
        SharedDirectivesModule,
        SortTableModule,
        NgSelectModule,
        SharedPipesModule
    ],
    declarations: [AllegationAllegationsComponent],
    exports: []
})
export class AllegationAllegationsModule {}
