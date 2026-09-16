import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonStatusSummaryRoutingModule } from './person-status-summary-routing.module';
import { PersonStatusSummaryComponent } from './person-status-summary.component';
import { FormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    MatSelectModule,
    PersonStatusSummaryRoutingModule
  ],
  declarations: [PersonStatusSummaryComponent]
})
export class PersonStatusSummaryModule { }
