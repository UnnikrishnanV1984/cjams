import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonHistoryDetailsRoutingModule } from './person-history-details-routing.module';
import { PersonHistoryDetailsComponent } from './person-history-details.component';
import { PersonLawEnfDetailsComponent } from './person-law-enf-details/person-law-enf-details.component';
import { ComplaintDetailsComponent } from './complaint-details/complaint-details.component';
import { VictimDetailsComponent } from './complaint-details/victim-details/victim-details.component';
import { PetitionDetailsComponent } from './complaint-details/petition-details/petition-details.component';
import { FolderDetailsComponent } from './complaint-details/folder-details/folder-details.component';
import { LegalActionHistoryService } from './person-law-enf-details/legal-action-history.service';
import { CompliantDetailsService } from './complaint-details/compliant-details.service';
import { CompliantDetailsResolverService } from './complaint-details/compliant-details-resolver.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    PersonHistoryDetailsRoutingModule,
    FormsModule,
    PaginationModule
  ],
  declarations: [PersonHistoryDetailsComponent, PersonLawEnfDetailsComponent, ComplaintDetailsComponent, VictimDetailsComponent, PetitionDetailsComponent, FolderDetailsComponent],
  providers: [LegalActionHistoryService, CompliantDetailsResolverService, CompliantDetailsService]

})
export class PersonHistoryDetailsModule { }
