import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ViewAssessmentComponent } from './view-assessment.component';
import { ViewAssessmentRoutingModule } from './view-assessment-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { AssessmentSexTraffickingComponent } from '../assessment-sex-trafficking/assessment-sex-trafficking.component';
import { AssessmentPlacementRequestFormBComponent } from '../assessment-placement-request-form-b/assessment-placement-request-form-b.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { AssessmentFacilitatedReferralFormComponent } from '../assessment-facilitated-referral-form/assessment-facilitated-referral-form.component';
import { SharedComponentsModule } from '../../../../../../app/shared/shared-components/shared-components.module';
import { AssessmentLapComponent } from '../assessment-lap/assessment-lap.component';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { AssessmentYouthIndicatorsComponent } from './../assessment-youth-indicators/assessment-youth-indicators.component';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};

export const CUSTOM_DATE_FORMATS: MatDateFormats = {
  parse: {
    dateInput: 'MM/DD/YYYY',
  },
  display: {
    dateInput: 'MM/DD/YYYY',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
}

@NgModule({
  imports: [
    CommonModule,
    ViewAssessmentRoutingModule,
    MatRadioModule,
    MatCheckboxModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    PaginationModule,
    SharedComponentsModule,
    NgxMaskDirective,
    NgxMaskPipe,
    MatMomentDatetimeModule, 
    MatDatetimepickerModule,
    OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule,SignatureFieldModule
  ],
  providers:[provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }, { provide: MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  declarations: [
    ViewAssessmentComponent,
    // AssessmentSafecOhpComponent,
    AssessmentSexTraffickingComponent,
    AssessmentPlacementRequestFormBComponent,
    AssessmentFacilitatedReferralFormComponent,
    AssessmentLapComponent,
    AssessmentYouthIndicatorsComponent,
    // ApprovalHistoryComponent
  ],
 exports:[
  // AssessmentCansOutComponent, 
  // ViewAssessmentCansSummaryComponent
]
})
export class ViewAssessmentModule { }
