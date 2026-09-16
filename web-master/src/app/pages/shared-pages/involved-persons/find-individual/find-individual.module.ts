import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FindIndividualRoutingModule } from './find-individual-routing.module';
import { FindIndividualComponent } from './find-individual.component';
import { SearchCriteriaComponent } from './search-criteria/search-criteria.component';
import { SearchResultComponent } from './search-result/search-result.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FindIndividualService } from './find-individual.service';
import { InvolvedPersonsService } from '../involved-persons.service';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { UIModule } from '../../../../lib/ui/ui.module';
import { ProgramParticipationModule } from '../../../../lib/programParticipation/programParticipation.module';
import { PersonSearchModule } from '../../../../pages/person-search/person-search.module';


@NgModule({
  imports: [
    CommonModule,
    FindIndividualRoutingModule,
    FormMaterialModule,
    PaginationModule,
    SharedPipesModule,
    SortTableModule,
    UIModule,
    ProgramParticipationModule,
    PersonSearchModule
  ],
  declarations: [FindIndividualComponent, SearchCriteriaComponent, SearchResultComponent],
  providers: [FindIndividualService, InvolvedPersonsService]
})
export class FindIndividualModule { }
