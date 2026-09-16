import { GoogleMapsModule } from '@angular/google-maps';

import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { PlacementRoutingModule } from './placement-routing.module';
import { PlacementComponent } from './placement.component';
import { PermanencyPlanComponent } from './permanency-plan/permanency-plan.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PlacementAddEditComponent } from './placement-add-edit/placement-add-edit.component';
import { MatCardModule } from '@angular/material/card';
import { MatNativeDateModule } from '@angular/material/core';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
     
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { PlacementGapService } from './placement-gap/placement-gap.service';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { MatTimepickerModule } from '@angular/material/timepicker';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';

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
        ReactiveFormsModule,
        FormsModule,
        PlacementRoutingModule,
        MatCheckboxModule,
        MatDatepickerModule,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatExpansionModule,
        // A2Edatetimepicker,
        GoogleMapsModule,
        PaginationModule,
        MatCardModule,
        MatListModule,
        MatNativeDateModule,
        MatRadioModule,
        MatTableModule,
        MatTabsModule,
        SharedDirectivesModule,
        MatMomentDatetimeModule, MatDatetimepickerModule,
        MatTimepickerModule,
        OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule, AttachmentUploadsharedModule
    ],
    declarations: [PlacementComponent, PermanencyPlanComponent, PlacementAddEditComponent],

    providers: [DatePipe, PlacementGapService, { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
})
export class PlacementModule {}
