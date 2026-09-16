import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgSelectModule } from '@ng-select/ng-select';

// import {A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PersonHealthComponent } from './person-health.component';
import { PersonHealthService } from './person-health.service';
import { PersonHealthRoutingModule } from './person-health-routing.module';
import { BirthInformationCwComponent } from './birth-information-cw/birth-information-cw.component';
import { Under5yearsCwComponent } from './under-5years-cw/under-5years-cw.component';
import { SubstanceAbuseComponent } from './substance-abuse/substance-abuse.component';
import { SexualInformationCwComponent } from './sexual-information-cw/sexual-information-cw.component';
import { HospitalizationCwComponent } from './hospitalization-cw/hospitalization-cw.component';
import { BehavioralHealthInfoCwComponent } from './behavioral-health-info-cw/behavioral-health-info-cw.component';
import { MedicationIncludingPsychotropicCwComponent } from './medication-including-psychotropic-cw/medication-including-psychotropic-cw.component';
import { ImmunizationCwComponent } from './immunization-cw/immunization-cw.component';
import { FamilyHistoryCwComponent } from './family-history-cw/family-history-cw.component';
import { InvolvedPersonsService } from '../../involved-persons/involved-persons.service';
import { PersonExaminationModule } from './person-examination/person-examination.module';
import { QuillModule } from 'ngx-quill';
import { ProviderInformationCwComponent } from './provider-information-cw/provider-information-cw.component';
import { PersonHealthDisabilityComponent } from './person-health-disability/person-health-disability.component';
import { PersonDisabilityService } from '../../person-disability/person-disability.service';
import { FeedingInfoCwComponent } from './feeding-info-cw/feeding-info-cw.component';
import { InsuranceInformationCwComponent } from './insurance-information-cw/insurance-information-cw.component';
import { MedicalConditionsCwComponent } from './medical-conditions-cw/medical-conditions-cw.component';
import { ShareFeaturesModule } from '../share-features/share-features.module';
import { SleepingComponent } from './sleeping/sleeping.component';
import { EliminationComponent } from './elimination/elimination.component';
import { MobilitySpeechCwComponent } from './mobility-speech-cw/mobility-speech-cw.component';
import { ChildRemovalService } from '../../../case-worker/dsds-action/child-removal/child-removal.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { HealthPassportComponent } from './health-passport/health-passport.component';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import {MatIconModule} from '@angular/material/icon';
import {MatMenuModule} from '@angular/material/menu';
import {MatButtonModule} from '@angular/material/button';
import { PersonHealthSummaryCwComponent } from './person-health-summary-cw/person-health-summary-cw.component';
import { DsdsService } from '../../../case-worker/dsds-action/_services/dsds.service';
import {MatTimepickerModule} from '@angular/material/timepicker';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { CustomTableModule } from '../../../../shared/shared-components/custom-table/custom-table.module';
import { AuditDataModule } from '../../../../shared/shared-components/audit-data/audit-data.module';
import { HospitalizationCwSharedModule } from '../../../../shared/shared-components/hospitalization-cw-shared/hospitalization-cw-shared.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    NgSelectModule,
    PersonHealthRoutingModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    // A2Edatetimepicker,
    PersonExaminationModule,
    QuillModule.forRoot(),
    ShareFeaturesModule,
    // SharedComponentsModule,
    PaginationModule,
    SharedPipesModule,
    MatButtonModule,
     MatMenuModule,
      MatIconModule,
      NgxMaskDirective,
      NgxMaskPipe,
    MatMomentDatetimeModule, MatDatetimepickerModule,
    MatTimepickerModule,
    DocumentUploadListSharedModule, AttachmentUploadsharedModule, CustomTableModule, AuditDataModule, HospitalizationCwSharedModule
  ],
  declarations: [
    PersonHealthComponent,
    BehavioralHealthInfoCwComponent,
     BirthInformationCwComponent,
     Under5yearsCwComponent,
     SubstanceAbuseComponent,
     SexualInformationCwComponent,
     HospitalizationCwComponent,
     MedicationIncludingPsychotropicCwComponent,
     FamilyHistoryCwComponent,
    EliminationComponent,
    MobilitySpeechCwComponent,
    MedicalConditionsCwComponent,
    ImmunizationCwComponent,
    ProviderInformationCwComponent,
    PersonHealthDisabilityComponent,
    FeedingInfoCwComponent,
    InsuranceInformationCwComponent,
    SleepingComponent,
    HealthPassportComponent,
    PersonHealthSummaryCwComponent
  ],
  exports: [
    PersonHealthDisabilityComponent
  ],
  providers: [PersonHealthService, InvolvedPersonsService,
  PersonDisabilityService, ChildRemovalService, DsdsService,provideNgxMask()]
})
export class PersonHealthInfoModule { }
