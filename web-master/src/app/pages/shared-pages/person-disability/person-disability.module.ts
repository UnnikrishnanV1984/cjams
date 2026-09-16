import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonDisabilityRoutingModule } from './person-disability-routing.module';
import { PersonDisabilityComponent } from './person-disability.component';
import { DisabilityListComponent } from './disability-list/disability-list.component';
import { DisabilityCreateUpdateComponent } from './disability-create-update/disability-create-update.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { PersonDisabilityService } from './person-disability.service';
import { PersonDisabilityResolverService } from './person-disability-resolver.service';
import { PersonDetailsService } from '../../person-details/person-details.service';

@NgModule({
  imports: [
    CommonModule,
    PersonDisabilityRoutingModule,
    FormMaterialModule
  ],
  declarations: [PersonDisabilityComponent,
     DisabilityListComponent,
     DisabilityCreateUpdateComponent],
  providers: [PersonDisabilityService, PersonDisabilityResolverService, PersonDetailsService]
})
export class PersonDisabilityModule { }
