import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonHealthComponent } from './person-health.component';
import { BirthInformationCwComponent } from './birth-information-cw/birth-information-cw.component';
import { SubstanceAbuseComponent } from './substance-abuse/substance-abuse.component';
import { SexualInformationCwComponent } from './sexual-information-cw/sexual-information-cw.component';
import { HospitalizationCwComponent } from './hospitalization-cw/hospitalization-cw.component';
import { BehavioralHealthInfoCwComponent } from './behavioral-health-info-cw/behavioral-health-info-cw.component';
import { MedicationIncludingPsychotropicCwComponent } from './medication-including-psychotropic-cw/medication-including-psychotropic-cw.component';
import { ImmunizationCwComponent } from './immunization-cw/immunization-cw.component';
import { FamilyHistoryCwComponent } from './family-history-cw/family-history-cw.component';
import { ProviderInformationCwComponent } from './provider-information-cw/provider-information-cw.component';
import { PersonHealthDisabilityComponent } from './person-health-disability/person-health-disability.component';
import { FeedingInfoCwComponent } from './feeding-info-cw/feeding-info-cw.component';
import { InsuranceInformationCwComponent } from './insurance-information-cw/insurance-information-cw.component';
import { MedicalConditionsCwComponent } from './medical-conditions-cw/medical-conditions-cw.component';
import { SleepingComponent } from './sleeping/sleeping.component';
import { EliminationComponent } from './elimination/elimination.component';
import { MobilitySpeechCwComponent } from './mobility-speech-cw/mobility-speech-cw.component';
import { HealthPassportComponent } from './health-passport/health-passport.component';
import { PersonHealthSummaryCwComponent } from './person-health-summary-cw/person-health-summary-cw.component';

const routes: Routes = [
    {
        path: '',
        component: PersonHealthComponent,
        children: [
            {
                path: 'examination',
                loadChildren: () => import( './person-examination/person-examination.module').then(m => m.PersonExaminationModule),
            },
            {
                path: 'person-health-summary',
                component: PersonHealthSummaryCwComponent,
            },
            {
                path: 'birth-info',
                component: BirthInformationCwComponent
            },
            {
                path: 'behavioral-health',
                component: BehavioralHealthInfoCwComponent
            },
            {
                path: 'substance-abuse',
                component: SubstanceAbuseComponent
            },
            {
                path: 're-productive-health',
                component: SexualInformationCwComponent
            },
            {
                path: 'hospitalization',
                component: HospitalizationCwComponent
            },
            {
                path: 'medication-psychotropic',
                component: MedicationIncludingPsychotropicCwComponent
            },
            {
                path: 'immunization',
                component: ImmunizationCwComponent
            },
            {
                path: 'family-history',
                component: FamilyHistoryCwComponent
            },
            {
                path: 'provider-info',
                component: ProviderInformationCwComponent
            },
            {
                path: 'disability',
                component: PersonHealthDisabilityComponent
            },
            {
                path: 'feeding-info',
                component: FeedingInfoCwComponent
            },
            {
                path: 'insurance-info',
                component: InsuranceInformationCwComponent
            },
            {
                path: 'diseases-conditions',
                component: MedicalConditionsCwComponent
            },
            {
                path: 'sleeping-info',
                component: SleepingComponent
            },
            {
                path: 'elimination',
                component: EliminationComponent
            },
            {
                path: 'mobility-speech',
                component: MobilitySpeechCwComponent
            },
            {
                path: 'health-passport',
                component: HealthPassportComponent
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PersonHealthRoutingModule { }
