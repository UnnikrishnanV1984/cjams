import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CourtActionsRoutingModule } from './court-actions-routing.module';
import { CourtActionsComponent } from './court-actions.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    CourtActionsRoutingModule,
    PaginationModule
  ],
  declarations: [CourtActionsComponent]
})
export class CourtActionsModule { }
