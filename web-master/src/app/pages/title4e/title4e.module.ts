import { ControlMessagesModule } from './../../shared/modules/control-messages/control-messages.module';
import { CommonModule } from '@angular/common';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { IntakeFilterPipe } from './pipes/intakeFilter';
// import { ChartModule } from 'angular2-highcharts';
// import { HighchartsStatic } from 'angular2-highcharts/dist/HighchartsService';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgxPrintModule } from 'ngx-print';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
// import { MatChipsModule } from '@angular/material/chips';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { Supervisor4eComponent } from './supervisor4e/supervisor4e.component';
import { Worker4eComponent } from './worker4e/worker4e.component';
import { Title4eRoutingModule } from './title4e-routing.module';
import { Title4eComponent } from './title4e.component';
import { PeriodTablePopUpComponent } from './period-table-pop-up/period-table-pop-up.component';
import { TitleIveFosterCarComponent } from './title-ive-foster-car/title-ive-foster-car.component';
import { EligibleWorksheetFormComponent } from './title-ive-foster-car/eligible-worksheet-form/eligible-worksheet-form.component';
import { AttachmentComponent } from './title-ive-foster-car/attachment/attachment.component';
import { DecisionsComponent } from './title-ive-foster-car/decisions/decisions.component';
import { EligibleDetailsComponent } from './title-ive-foster-car/eligible-details/eligible-details.component';
import { NarrativesComponent } from './title-ive-foster-car/narratives/narratives.component';
import { ReportComponent } from './title-ive-foster-car/report/report.component';
import { Title4eService } from './services/title4e.service';
import { SummaryComponent } from './title-ive-foster-car/summary/summary.component';
import { IveAfcarsReportComponent } from './iveafcarsreport/ive-afcars-report.component';
import { IveCSMSReportComponent } from './ivecsmsreport/ive-csms-report.component';
export function highchartfactory() {
    return require('highcharts');
}
import { NgxCurrencyDirective, NgxCurrencyInputMode, provideEnvironmentNgxCurrency } from 'ngx-currency';
// import { CurrencyMaskConfig } from 'ngx-currency/src/currency-mask.config';
// import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';
import {NgxPaginationModule} from 'ngx-pagination';
import { DynamicModule } from 'ng-dynamic-component';
import { FormMaterialModule } from '../../@core/form-material.module';
import { TitleIveadoptionService } from './adoption/title-iveadoption.service';
import { Title4eFosterCareService } from './title-ive-foster-car/title4e-foster-care.service';
import { MatMenuModule } from '@angular/material/menu';
import { SharedComponentsModule } from '../../../../src/app/shared/shared-components/shared-components.module';
import { DsdsService } from '../case-worker/dsds-action/_services/dsds.service';
import { DashboardWidgetComponent } from './dashboard-widget/dashboard-widget.component';
import { Dashboard4eComponent } from './dashboard4e/dashboard4e.component';
import { HighchartsChartModule } from 'highcharts-angular';
import { SignatureFieldModule } from '../../shared/modules/common-controls/signature-field/signature-field.module';
import { AttachmentUploadsharedModule } from '../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { DocumentUploadListSharedModule } from '../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { EditAttachmentSharedModule } from '../../shared/shared-components/edit-attachment-shared/edit-attachment-shared.module';
import { CustomTableModule } from '../../shared/shared-components/custom-table/custom-table.module';
export const CustomCurrencyMaskConfig: any = {
    align: 'right',
    allowNegative: true,
    allowZero: true,
    decimal: ',',
    precision: 2,
    prefix: 'R$ ',
    suffix: '',
    thousands: '.',
    nullable: true
};
@NgModule({
    imports: [AttachmentUploadsharedModule,DocumentUploadListSharedModule,EditAttachmentSharedModule,MatTooltipModule, MatFormFieldModule, CommonModule, CustomTableModule,  
        // ChartModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        FormMaterialModule,
        NgxPaginationModule,
        NgxCurrencyDirective,
        MatDatepickerModule,
        MatNativeDateModule,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatButtonModule,
        MatRadioModule,
        MatTabsModule,
        MatTooltipModule,
        MatCheckboxModule,
        MatListModule,
        MatCardModule,
        MatTableModule,
        MatExpansionModule,
        MatStepperModule,
        MatPaginatorModule,
        // MatChipsModule,
        MatIconModule,
        MatDialogModule,
        QuillModule.forRoot(),
        DynamicModule,
        Title4eRoutingModule, FormsModule, ReactiveFormsModule, PaginationModule, SharedDirectivesModule,
        SharedPipesModule, MatAutocompleteModule, SortTableModule, NgSelectModule, 
        // A2Edatetimepicker, 
        // AngularSignaturePadModule,
         NgxPrintModule,
        ControlMessagesModule,MatMenuModule,
        // SharedComponentsModule,
        HighchartsChartModule,
        SignatureFieldModule,
        SharedComponentsModule
    ],

        
    declarations: [Supervisor4eComponent,
        IveAfcarsReportComponent,
        IveCSMSReportComponent,
        Title4eComponent, Worker4eComponent, PeriodTablePopUpComponent, IntakeFilterPipe,
        TitleIveFosterCarComponent, EligibleWorksheetFormComponent,
        Dashboard4eComponent,
        EligibleDetailsComponent, AttachmentComponent, DecisionsComponent, NarrativesComponent, ReportComponent, SummaryComponent, DashboardWidgetComponent],


    providers: [
        // { provide: HighchartsStatic, useFactory: highchartfactory }, Title4eService  , DsdsService,
        TitleIveadoptionService, // add as factory to your providers
        Title4eFosterCareService,
        Title4eService,
        DsdsService,
        provideEnvironmentNgxCurrency(CustomCurrencyMaskConfig)
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA],
    exports: []
})
export class Title4eModule { }