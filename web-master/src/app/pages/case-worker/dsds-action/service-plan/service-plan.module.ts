import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { CommonHttpService } from '../../../../@core/services';
import { GoalStrategyComponent } from './goal-strategy/goal-strategy.component';
import { ServiceLogComponent } from './service-plan-activity/service-log/service-log.component';
import { ServicePlanActivityComponent } from './service-plan-activity/service-plan-activity.component';
import { ServicePlanAddEditActivityComponent } from './service-plan-add-edit-activity/service-plan-add-edit-activity.component';
import { ServicePlanAddEditServiceComponent } from './service-plan-add-edit-service/service-plan-add-edit-service.component';
import { ServicePlanRoutingModule } from './service-plan-routing.module';
import { ServicePlanComponent } from './service-plan.component';
import { GoogleMapsModule } from '@angular/google-maps';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { ServiceCaseManagementModule } from '../../../shared-pages/service-case-management/service-case-management.module';
import { ServicePlanResolverService } from './service-plan-resolver-service';
import { MatTooltipModule } from '@angular/material/tooltip';
import { SharedService } from './_service/shared-service';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { MatTimepickerModule } from '@angular/material/timepicker';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';

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
        ServicePlanRoutingModule,
        MatTabsModule,
        MatSelectModule,
        MatTableModule,
        MatDatepickerModule,
        MatFormFieldModule,
        MatInputModule,
        MatCheckboxModule,
        MatAutocompleteModule,
        ReactiveFormsModule,
        FormsModule,
        PaginationModule,
        // A2Edatetimepicker,
        NgSelectModule,
        GoogleMapsModule,
        SharedDirectivesModule,
        MatTooltipModule,
        ServiceCaseManagementModule,
        NgxMaskDirective,
        NgxMaskPipe,
        MatMomentDatetimeModule, MatDatetimepickerModule,
        MatTimepickerModule,
        OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule
        //AgmCoreModule.forRoot({
            //apiKey: environment.googleMapApi
        //})
    ],
    declarations: [
        ServicePlanComponent,
        GoalStrategyComponent,
        ServicePlanActivityComponent,
        ServicePlanAddEditActivityComponent,
        ServicePlanAddEditServiceComponent,
        ServiceLogComponent
        // AgencyProvidedServicesComponent,
        // ReferredServicesComponent,
        // ServiceLogActivityComponent
    ],
    providers: [CommonHttpService,ServicePlanResolverService,SharedService,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
})
export class ServicePlanModule {}
