import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { CaseWorkerRoutingModule } from './case-worker-routing.module';
import { CaseWorkerComponent } from './case-worker.component';
import { DashboardComponent } from './dashboard.component';
import { FormLetterComponent } from './form-letter/form-letter.component';
import { NotificationComponent } from './notification/notification.component';
import { RoutingComponent } from './routing/routing.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxfUploaderService, NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
// import { QuillModule } from 'ngx-quill';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { CaseWorkerResolverService } from './case-worker-resolver.service';
import { DsdsService } from './dsds-action/_services/dsds.service';
import { FormMaterialModule } from '../../@core/form-material.module';
import { CaseConnectedComponent } from './dsds-action/case-connected/case-connected.component'
import { NgSelectModule } from '@ng-select/ng-select';
// import { SharedComponentsModule } from '../../shared/shared-components/shared-components.module';
import { PersonDisabilityService } from '../shared-pages/person-disability/person-disability.service';
import { ChildRemovalService } from './dsds-action/child-removal/child-removal.service';
import { DocumentUploadListSharedModule } from '../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { CustomTableModule } from '../../shared/shared-components/custom-table/custom-table.module';
import { GlobalPopupModule } from '../../shared/shared-components/global-popup/global-popup.module';

@NgModule({
    imports: [CommonModule,
        CaseWorkerRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        PaginationModule,
        SortTableModule,
        // A2Edatetimepicker,
        SharedPipesModule,
        SharedDirectivesModule,
        // QuillModule.forRoot(),
        FormMaterialModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        NgSelectModule,
        // SharedComponentsModule,
        DocumentUploadListSharedModule, AttachmentUploadsharedModule, CustomTableModule, GlobalPopupModule
    ],
    declarations: [CaseWorkerComponent, RoutingComponent, NotificationComponent, FormLetterComponent, DashboardComponent, CaseConnectedComponent],
    providers: [ChildRemovalService, PersonDisabilityService, NgxfUploaderService, IntakeUtils, CaseWorkerResolverService, DsdsService]
})
export class CaseWorkerModule { }
