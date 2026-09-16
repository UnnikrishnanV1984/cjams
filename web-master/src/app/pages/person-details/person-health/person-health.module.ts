import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
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

import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { PersonHealthRoutingModule } from './person-health-routing.module';
import { PersonHealthComponent } from './person-health.component';
import { PhysicianInformationComponent } from './physician-information/physician-information.component';
import { HealthInsuranceInformationComponent } from './health-insurance-information/health-insurance-information.component';
import { MedicationIncludingPsychotropicComponent } from './medication-including-psychotropic/medication-including-psychotropic.component';
import { HealthExaminationComponent } from './health-examination/health-examination.component';
import { HistoryOfAbuseComponent } from './history-of-abuse/history-of-abuse.component';
import { MedicalConditionsComponent } from './medical-conditions/medical-conditions.component';
import { BehavioralHealthInfoComponent } from './behavioral-health-info/behavioral-health-info.component';
import { SubstanceAbuseComponent } from './substance-abuse/substance-abuse.component';
import { PersonHealthSectionLogComponent } from './person-health-section-log/person-health-section-log.component';
import { PhysicianInformationListComponent } from './physician-information/physician-information-list/physician-information-list.component';
import { PhysicianInformationCreateEditComponent } from './physician-information/physician-information-create-edit/physician-information-create-edit.component';
import { MedicationIncludingPsychotropicCreateEditComponent
} from './medication-including-psychotropic/medication-including-psychotropic-create-edit/medication-including-psychotropic-create-edit.component';
import { MedicationIncludingPsychotropicListComponent } from './medication-including-psychotropic/medication-including-psychotropic-list/medication-including-psychotropic-list.component';
import { HealthExaminaionCreateEditComponent } from './health-examination/health-examinaion-create-edit/health-examinaion-create-edit.component';
import { HealthExaminaionListComponent } from './health-examination/health-examinaion-list/health-examinaion-list.component';
import { MedicalConditionsCreateEditComponent } from './medical-conditions/medical-conditions-create-edit/medical-conditions-create-edit.component';
import { MedicalConditionsListComponent } from './medical-conditions/medical-conditions-list/medical-conditions-list.component';
import { BehavioralHealthInfoCreateEditComponent } from './behavioral-health-info/behavioral-health-info-create-edit/behavioral-health-info-create-edit.component';
import { BehavioralHealthInfoListComponent } from './behavioral-health-info/behavioral-health-info-list/behavioral-health-info-list.component';
import { HealthInsuranceInformationCreateEditComponent } from './health-insurance-information/health-insurance-information-create-edit/health-insurance-information-create-edit.component';
import { HealthInsuranceInformationListComponent } from './health-insurance-information/health-insurance-information-list/health-insurance-information-list.component';
import { VisionComponent } from './vision/vision.component';
import { ImmunizationsComponent } from './immunizations/immunizations.component';
import { DentalInformationCwComponent } from './dental-information-cw/dental-information-cw.component';


@NgModule({
  imports: [
    CommonModule,
    PersonHealthRoutingModule,
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
    MatAutocompleteModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  declarations: [
    PersonHealthComponent,
    PhysicianInformationComponent,
    HealthInsuranceInformationComponent,
    MedicationIncludingPsychotropicComponent,
    HealthExaminationComponent,
    MedicalConditionsComponent,
    BehavioralHealthInfoComponent,
    HistoryOfAbuseComponent,
    SubstanceAbuseComponent,
    PersonHealthSectionLogComponent,
    PhysicianInformationListComponent,
    PhysicianInformationCreateEditComponent,
    MedicationIncludingPsychotropicCreateEditComponent,
    MedicationIncludingPsychotropicListComponent,
    HealthExaminaionCreateEditComponent,
    HealthExaminaionListComponent,
    MedicalConditionsCreateEditComponent,
    MedicalConditionsListComponent,
    BehavioralHealthInfoCreateEditComponent,
    BehavioralHealthInfoListComponent,
    HealthInsuranceInformationCreateEditComponent,
    HealthInsuranceInformationListComponent,
    VisionComponent,
    DentalInformationCwComponent,
    ImmunizationsComponent],
  providers: [NgxfUploaderService,provideNgxMask()]
})
export class PersonHealthModule { }
