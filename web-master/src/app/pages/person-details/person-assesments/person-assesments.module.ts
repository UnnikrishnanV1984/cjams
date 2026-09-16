import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonAssesmentsRoutingModule } from './person-assesments-routing.module';
import { PersonAssesmentsComponent } from './person-assesments.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PersonAssesmentsService } from './person-assesments.service';
import { FormsModule } from '@angular/forms';
import { PersonAssementsResolverService } from './person-assements-resolver.service';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    PersonAssesmentsRoutingModule,
    PaginationModule
  ],
  declarations: [PersonAssesmentsComponent],
  providers: [PersonAssesmentsService, PersonAssementsResolverService]
})
export class PersonAssesmentsModule { }
