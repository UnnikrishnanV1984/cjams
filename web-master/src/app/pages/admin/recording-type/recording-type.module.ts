import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { PageHeaderModule } from '../../../shared';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { AddEditRecordingTypeComponent } from './add-edit-recording-type.component';
import { RecordingTypeRoutingModule } from './recording-type-routing.module';
import { RecordingTypeComponent } from './recording-type.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
    imports: [
        CommonModule,
        RecordingTypeRoutingModule,
        PageHeaderModule,
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        SharedDirectivesModule,
        NgSelectModule,
        SharedPipesModule,
        // A2Edatetimepicker,
        SortTableModule,
        PaginationModule,
        MatDatepickerModule,
        MatFormFieldModule
    ],
    declarations: [RecordingTypeComponent, AddEditRecordingTypeComponent],
    exports: []
})
export class RecordingTypeModule {}
