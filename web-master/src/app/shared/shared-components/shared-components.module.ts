import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MatMenuModule } from '@angular/material/menu';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonControlsModule } from '../modules/common-controls/common-controls.module';
import { MatSortModule } from '@angular/material/sort';
import { MatRadioModule } from '@angular/material/radio';
import { SharedPipesModule } from '../../../../src/app/@core/pipes/shared-pipes.module';
import { NgxMaskDirective, NgxMaskPipe, provideNgxMask } from 'ngx-mask';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { ControlMessagesModule } from '../modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { FormMaterialModule } from '../../../../src/app/@core/form-material.module';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ProviderAddressModule } from './provider-address/provider-address.module';
import { ShareFeaturesModule } from '../../pages/shared-pages/person-info/share-features/share-features.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { HelpPopoverComponent } from './help-popover/help-popover.component';
import { Form1080AComponent } from './forms/form-1080-a/form-1080-a.component';
import { Form1080BComponent } from './forms/form-1080-b/form-1080-b.component';
import { Form1080CComponent } from './forms/form-1080-c/form-1080-c.component';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { UploadProgressWidgetModule } from './upload-progress-widget/upload-progress-widget.module';
import { CustomTableModule } from './custom-table/custom-table.module';
import { CustomInfoTooltipModule } from './custom-info-tooltip/custom-info-tooltip.module';
import { CustomSearchModule } from './custom-search/custom-search.module';
import { EditAttachmentSharedModule } from './edit-attachment-shared/edit-attachment-shared.module';
import { DocumentUploadListSharedModule } from './document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from './attachment-upload-shared/attachment-upload-shared.module';
import { AuditDataModule } from './audit-data/audit-data.module';
import { HospitalizationCwSharedModule } from './hospitalization-cw-shared/hospitalization-cw-shared.module';
import { AuditAccessLogsModule } from './audit-access-logs/audit-access-logs.module';
import { CustomTableActionsModule } from './custom-table-actions/custom-table-actions.module';
import { GlobalPopupModule } from './global-popup/global-popup.module';
import { ScanSharedAttachementModule } from './scan-shared-attachement/scan-shared-attachement.module';
import { AttachementScanDetailModule } from './attachement-scan-detail/attachement-scan-detail.module';
import { SignatureFieldModule } from '../modules/common-controls/signature-field/signature-field.module';
import { BarGraphComponent } from './bar-graph/bar-graph.component';
import { WidgetComponentComponent } from './widget-component/widget-component.component';
import { HighchartsChartModule } from 'highcharts-angular';
import { TextFieldModule } from '@angular/cdk/text-field';
@NgModule({
  imports: [
    CommonModule,
    SharedDirectivesModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    SharedPipesModule,
    MatMenuModule,
    FormsModule,
    MatSortModule,
    BsDatepickerModule,
    SortTableModule,
    PaginationModule,
    ReactiveFormsModule,
    CommonControlsModule,
    MatRadioModule,
    MatCheckboxModule,
    MatTooltipModule,
    ControlMessagesModule,
    NgSelectModule,
    FormMaterialModule,
    ProviderAddressModule,
    ShareFeaturesModule,
    PopoverModule,
    DragDropModule,
    HighchartsChartModule,
    MatFormFieldModule,
    MatInputModule,
    NgxMaskDirective, NgxMaskPipe, UploadProgressWidgetModule, CustomTableModule, CustomInfoTooltipModule, CustomSearchModule, EditAttachmentSharedModule, DocumentUploadListSharedModule, AttachmentUploadsharedModule, AuditDataModule, HospitalizationCwSharedModule, AuditAccessLogsModule, CustomTableActionsModule, GlobalPopupModule, ScanSharedAttachementModule, AttachementScanDetailModule,SignatureFieldModule, TextFieldModule
  ],
  declarations: [
    HelpPopoverComponent,
    Form1080AComponent,
    Form1080BComponent,
    Form1080CComponent,
    BarGraphComponent,
    WidgetComponentComponent
    ],
  exports: [HelpPopoverComponent,BarGraphComponent,WidgetComponentComponent],
  providers:[provideNgxMask()]//providers:[{ provide: 'Socket', useValue: socket }]
})
export class SharedComponentsModule { }
