import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonDocumentsRoutingModule } from './person-documents-routing.module';
import { PersonDocumentsComponent } from './person-documents.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';
import { PersonDocumentsService } from './person-documents.service';
import { PersonDocumentsResolverService } from './person-documents-resolver.service';
@NgModule({
  imports: [
    CommonModule,
    PersonDocumentsRoutingModule,
    PaginationModule,
    FormsModule
  ],
  declarations: [PersonDocumentsComponent],
  providers: [PersonDocumentsService, PersonDocumentsResolverService]
})
export class PersonDocumentsModule { }
