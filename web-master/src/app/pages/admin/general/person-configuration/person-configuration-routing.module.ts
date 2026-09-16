import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import {
    AddressTypeComponent,
    EmployeeTypeComponent,
    EthnicGroupTypeComponent,
    GenderTypeComponent,
    IdentifierTypeComponent,
    IncomeTypeComponent,
    LanguageTypeComponent,
    LivingArrangementTypeComponent,
    MaritalStatusTypeComponent,
    PersonRoleComponent,
    PhoneTypeComponent,
    RaceTypeComponent
} from '.';
import { PersonConfigurationComponent } from './person-configuration.component';

const routes: Routes = [
    {
        path: '',
        component: PersonConfigurationComponent,
        children: [
            { path: 'address-type', component: AddressTypeComponent },
            { path: 'employee-type', component: EmployeeTypeComponent },
            { path: 'ethnic-group-type', component: EthnicGroupTypeComponent },
            { path: 'gender-type', component: GenderTypeComponent },
            { path: 'identifier-type', component: IdentifierTypeComponent },
            { path: 'income-type', component: IncomeTypeComponent },
            { path: 'language-type', component: LanguageTypeComponent },
            { path: 'living-arrangement-type', component: LivingArrangementTypeComponent },
            { path: 'marital-status-type', component: MaritalStatusTypeComponent },
            { path: 'person-role', component: PersonRoleComponent },
            { path: 'phone-type', component: PhoneTypeComponent },
            { path: 'race-type', component: RaceTypeComponent },
            { path: '', redirectTo: 'ethnic-group-type', pathMatch: 'full' }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PersonConfigurationRoutingModule {}
