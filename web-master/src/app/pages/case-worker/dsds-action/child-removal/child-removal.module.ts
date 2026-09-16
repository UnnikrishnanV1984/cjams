import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ChildRemovalRoutingModule } from './child-removal-routing.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ChildRemovalWrapperComponent } from './child-removal-wrapper/child-removal-wrapper.component';
import { ChildRemovalComponent } from './child-removal.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { QuillModule } from 'ngx-quill';
import { ChildRemovalFormComponent } from './child-removal-form/child-removal-form.component';
import { ChildCardListComponent } from './child-card-list/child-card-list.component';
import { ChildRemovalService } from './child-removal.service';
import { ChildRemovalDetailComponent } from './child-removal-detail/child-removal-detail.component';
import { ChildRemovalResolverService } from './child-removal-resolver.service';
import { ChildRemovalMapperService } from './child-removal-mapper.service';
import { PersonDisabilityService } from '../../../shared-pages/person-disability/person-disability.service';
import { PersonInfoService } from '../../../shared-pages/person-info/person-info.service';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import { PersonHealthInfoModule } from '../../../shared-pages/person-info/person-health/person-health-info.module';
import { CaseWorkerViewAssessmentModule } from '../assessment/case-worker-view-assessment/case-worker-view-assessment.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import {MatTimepickerModule} from '@angular/material/timepicker';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module'; 
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';

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
    ChildRemovalRoutingModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    PersonHealthInfoModule,
    CaseWorkerViewAssessmentModule,
    PopoverModule,
    SharedPipesModule,
    NgxMaskDirective,
    NgxMaskPipe,
    MatMomentDatetimeModule, MatDatetimepickerModule,
    MatTimepickerModule,
    // SharedComponentsModule,
    OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule,
    GlobalPopupModule
  ],
  
  declarations: [ChildRemovalWrapperComponent, ChildRemovalComponent, ChildRemovalFormComponent, ChildCardListComponent, ChildRemovalDetailComponent],
  providers: [ChildRemovalService, ChildRemovalResolverService, ChildRemovalMapperService, PersonDisabilityService, PersonInfoService, NavigationUtils,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
})
export class ChildRemovalModule { }
