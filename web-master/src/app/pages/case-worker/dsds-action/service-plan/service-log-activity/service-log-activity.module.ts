import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ServiceCaseManagementModule } from '../../../../shared-pages/service-case-management/service-case-management.module';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatButtonModule } from '@angular/material/button';
import { MatAutocompleteModule } from '@angular/material/autocomplete';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgxMaskDirective, NgxMaskPipe, provideNgxMask} from 'ngx-mask';
import { NgSelectModule } from '@ng-select/ng-select';

import { CommonHttpService } from '../../../../../@core/services';
import { ServiceLogActivityRoutingModule } from './service-log-activity-routing.module';
import { GoogleMapsModule } from '@angular/google-maps';

import { AgencyProvidedServicesComponent } from '../service-log-activity/agency-provided-services/agency-provided-services.component';
import { ReferredServicesComponent } from '../service-log-activity/referred-services/referred-services.component';
import { ServiceLogActivityComponent } from './service-log-activity.component';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { CategoryPipe } from '../../../../../@core/pipes/category.pipe';
// import { SharedComponentsModule } from '../../../../../shared/shared-components/shared-components.module';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { MatTimepickerModule } from '@angular/material/timepicker';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { DocumentUploadListSharedModule } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};

@NgModule({
    imports: [
        CommonModule,
        ServiceLogActivityRoutingModule,
        MatAutocompleteModule,
        ReactiveFormsModule,
        FormsModule,
        PaginationModule,
        // A2Edatetimepicker,
        NgSelectModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        MatDatepickerModule,
        MatNativeDateModule,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatButtonModule,
        MatRadioModule,
        MatTabsModule,
        MatCheckboxModule,
        MatListModule,
        MatCardModule,
        MatTableModule,
        MatExpansionModule,
        // AgmCoreModule
        GoogleMapsModule,
        SharedDirectivesModule,
        SortTableModule,
        ServiceCaseManagementModule,
        // ShareFeaturesModule
        // SharedComponentsModule,
        NgxMaskDirective,
        NgxMaskPipe,
        MatMomentDatetimeModule, MatDatetimepickerModule,
        MatTimepickerModule,
        OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule,
        DocumentUploadListSharedModule, AttachmentUploadsharedModule
    ],
    declarations: [
        AgencyProvidedServicesComponent,
        ReferredServicesComponent,
        ServiceLogActivityComponent,
        CategoryPipe
    ],
    providers: [CommonHttpService,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
})
export class ServiceLogActivityModule {}