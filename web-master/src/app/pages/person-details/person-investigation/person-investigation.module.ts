import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonInvestigationRoutingModule } from './person-investigation-routing.module';
import { PersonInvestigationComponent } from './person-investigation.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    PersonInvestigationRoutingModule,
    PaginationModule,
    FormsModule
  ],
  declarations: [PersonInvestigationComponent]
})
export class PersonInvestigationModule { }
