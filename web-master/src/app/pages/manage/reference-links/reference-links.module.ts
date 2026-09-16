import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { ReferenceLinksRoutingModule } from './reference-links-routing.module';
import { ReferenceLinksComponent } from './reference-links.component';


@NgModule({
  imports: [
    CommonModule,
    ReferenceLinksRoutingModule, PaginationModule, FormsModule,
     ReactiveFormsModule, ControlMessagesModule, SortTableModule, SortTableModule
  ],
  declarations: [ReferenceLinksComponent]
})
export class ReferenceLinksModule { }
