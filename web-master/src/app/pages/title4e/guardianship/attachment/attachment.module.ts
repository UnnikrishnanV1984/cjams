import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatTooltipModule } from '@angular/material/tooltip';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { SharedComponentsModule } from '../../../../../../src/app/shared/shared-components/shared-components.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { AttachmentResolverService } from './attachment-resolver-service';
import { AttachmentComponent } from './attachment.component';

@NgModule({
    imports: [
        CommonModule,
        MatCheckboxModule,
        MatTooltipModule,
        FormsModule,
        ReactiveFormsModule,
        // A2Edatetimepicker,
        ControlMessagesModule,
        NgSelectModule, SharedPipesModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
         FormMaterialModule,
        PaginationModule,
        SortTableModule,
        SharedComponentsModule,
        NgxMaskDirective,
        NgxMaskPipe
    ],
    declarations: [
        AttachmentComponent
    ],
    providers:[AttachmentResolverService,provideNgxMask()]
})
export class AttachmentModule { }
