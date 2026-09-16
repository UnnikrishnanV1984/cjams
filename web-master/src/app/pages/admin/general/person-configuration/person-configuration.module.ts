import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

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
    RaceTypeComponent,
} from '.';
import { AdminSharedModule } from '../../_shared/admin-shared.module';
import { PersonConfigurationRoutingModule } from './person-configuration-routing.module';
import { PersonConfigurationComponent } from './person-configuration.component';

@NgModule({
  imports: [
    CommonModule,
    AdminSharedModule,
    PersonConfigurationRoutingModule,
    FormsModule, ReactiveFormsModule,
  ],
  declarations: [PersonConfigurationComponent,
    AddressTypeComponent, EmployeeTypeComponent, EthnicGroupTypeComponent,
    GenderTypeComponent, IdentifierTypeComponent, IncomeTypeComponent, LanguageTypeComponent, LivingArrangementTypeComponent,
    MaritalStatusTypeComponent, PersonRoleComponent, PhoneTypeComponent, RaceTypeComponent],
  providers: []

})
export class PersonConfigurationModule { }
