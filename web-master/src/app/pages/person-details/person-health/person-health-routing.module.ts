import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonHealthComponent } from './person-health.component';
import { RoleGuard } from '../../../@core/guard';
import { PhysicianInformationComponent } from './physician-information/physician-information.component';
import { HealthInsuranceInformationComponent } from './health-insurance-information/health-insurance-information.component';
import { MedicationIncludingPsychotropicComponent } from './medication-including-psychotropic/medication-including-psychotropic.component';
import { HealthExaminationComponent } from './health-examination/health-examination.component';
import { HistoryOfAbuseComponent } from './history-of-abuse/history-of-abuse.component';
import { MedicalConditionsComponent } from './medical-conditions/medical-conditions.component';
import { BehavioralHealthInfoComponent } from './behavioral-health-info/behavioral-health-info.component';
import { SubstanceAbuseComponent } from './substance-abuse/substance-abuse.component';
import { PersonHealthSectionLogComponent } from './person-health-section-log/person-health-section-log.component';
import { PhysicianInformationCreateEditComponent } from './physician-information/physician-information-create-edit/physician-information-create-edit.component';
import { PhysicianInformationService } from './physician-information/physician-information.service';
import { PhysicianInformationListComponent } from './physician-information/physician-information-list/physician-information-list.component';
import { MedicationIncludingPsychotropicListComponent } from './medication-including-psychotropic/medication-including-psychotropic-list/medication-including-psychotropic-list.component';
import { HealthExaminaionCreateEditComponent } from './health-examination/health-examinaion-create-edit/health-examinaion-create-edit.component';
import { HealthExaminaionListComponent } from './health-examination/health-examinaion-list/health-examinaion-list.component';
import { MedicalConditionsCreateEditComponent } from './medical-conditions/medical-conditions-create-edit/medical-conditions-create-edit.component';
import { MedicalConditionsListComponent } from './medical-conditions/medical-conditions-list/medical-conditions-list.component';
import { BehavioralHealthInfoCreateEditComponent } from './behavioral-health-info/behavioral-health-info-create-edit/behavioral-health-info-create-edit.component';
import { BehavioralHealthInfoListComponent } from './behavioral-health-info/behavioral-health-info-list/behavioral-health-info-list.component';
import { HealthInsuranceInformationCreateEditComponent } from './health-insurance-information/health-insurance-information-create-edit/health-insurance-information-create-edit.component';
import { HealthInsuranceInformationListComponent } from './health-insurance-information/health-insurance-information-list/health-insurance-information-list.component';
import { HealthInsuranceInformationService } from './health-insurance-information/health-insurance-information.service';
import { BehavioralHealthInfoService } from './behavioral-health-info/behavioral-health-info.service';
import { HealthExaminationService } from './health-examination/health-examination.service';
import { MedicalConditionsService } from './medical-conditions/medical-conditions.service';
import { MedicationIncludingPsychotropicService } from './medication-including-psychotropic/medication-including-psychotropic.service';
import {
  MedicationIncludingPsychotropicCreateEditComponent
} from './medication-including-psychotropic/medication-including-psychotropic-create-edit/medication-including-psychotropic-create-edit.component';
import { DentalInformationCwComponent } from './dental-information-cw/dental-information-cw.component';
import { VisionComponent } from './vision/vision.component';
import { ImmunizationsComponent } from './immunizations/immunizations.component';
import { SubstanceAbuseService } from './substance-abuse/substance-abuse.service';

const createeditpath = 'create-edit';
const routes: Routes = [
  {
    path: '',
    component: PersonHealthComponent,
    children: [
      {
        path: 'physician', component: PhysicianInformationComponent,
        children: [
          { path: createeditpath, component: PhysicianInformationCreateEditComponent },
          { path: 'list', component: PhysicianInformationListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      {
        path: 'health-insurance', component: HealthInsuranceInformationComponent,
        children: [
          { path: createeditpath, component: HealthInsuranceInformationCreateEditComponent },
          { path: 'list', component: HealthInsuranceInformationListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      {
        path: 'medication-psychotropic', component: MedicationIncludingPsychotropicComponent,
        children: [
          { path: createeditpath, component: MedicationIncludingPsychotropicCreateEditComponent },
          { path: 'list', component: MedicationIncludingPsychotropicListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      {
        path: 'health-examination', component: HealthExaminationComponent,
        children: [
          { path: createeditpath, component: HealthExaminaionCreateEditComponent },
          { path: 'list', component: HealthExaminaionListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      {
        path: 'medical-conditions', component: MedicalConditionsComponent,
        children: [
          { path: createeditpath, component: MedicalConditionsCreateEditComponent },
          { path: 'list', component: MedicalConditionsListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      {
        path: 'behavioral-health-info', component: BehavioralHealthInfoComponent,
        children: [
          { path: createeditpath, component: BehavioralHealthInfoCreateEditComponent },
          { path: 'list', component: BehavioralHealthInfoListComponent },
          { path: '**', redirectTo: 'list' }
        ]
      },
      { path: 'history-of-abuse', component: HistoryOfAbuseComponent },
      { path: 'provider-dental-information', component: DentalInformationCwComponent },
      { path: 'vision', component: VisionComponent },
      { path: 'immunization', component: ImmunizationsComponent },
      { path: 'substance-abuse', component: SubstanceAbuseComponent },
      { path: 'logs', component: PersonHealthSectionLogComponent },
      { path: '**', redirectTo: 'physician' },
    ],
    canActivate: [RoleGuard],
    data: {
      screen: { modules: ['pages', 'menus'], skip: false }
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [BehavioralHealthInfoService, HealthExaminationService,
    PhysicianInformationService, HealthInsuranceInformationService, MedicalConditionsService, MedicationIncludingPsychotropicService, SubstanceAbuseService]
})
export class PersonHealthRoutingModule { }
