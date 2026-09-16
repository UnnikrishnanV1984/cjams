import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { ClientEventHistoryRoutingModule } from './client-event-history-routing.module';
import { ClientEventHistoryComponent } from './client-event-history.component';
import { ClientEventHistoryService } from './client-event-history.service';
import { MatSelectModule } from '@angular/material/select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    ClientEventHistoryRoutingModule,
    FormsModule,
    MatSelectModule,
    PaginationModule

  ],
  declarations: [ClientEventHistoryComponent],
  providers: [ClientEventHistoryService]
})
export class ClientEventHistoryModule { }
