import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { NewsRoutingModule } from './news-routing.module';
import { NewsComponent } from './news.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@NgModule({
  imports: [
    CommonModule,
    NewsRoutingModule,
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SortTableModule
  ],
  declarations: [NewsComponent]
})
export class NewsModule { }
