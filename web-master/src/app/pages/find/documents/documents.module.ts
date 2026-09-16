import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DocumentsRoutingModule } from './documents-routing.module';
import { DocumentsComponent } from './documents.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DocumentsViewComponent } from './documents-view/documents-view.component';
import { DocumentsSearchComponent } from './documents-search/documents-search.component';
import { DocumentsResultsComponent } from './documents-results/documents-results.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    DocumentsRoutingModule,
    FormsModule,
    PaginationModule,
    ReactiveFormsModule,
    // A2Edatetimepicker
    MatFormFieldModule,
    MatDatepickerModule
  ],
  declarations: [DocumentsComponent, DocumentsViewComponent, DocumentsSearchComponent, DocumentsResultsComponent]
})
export class DocumentsModule { }
