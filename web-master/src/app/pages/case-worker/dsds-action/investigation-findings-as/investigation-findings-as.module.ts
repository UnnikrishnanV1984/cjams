import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { InvestigationFindingsAsRoutingModule } from './investigation-findings-as-routing.module';
import { InvestigationFindingsAsComponent } from './investigation-findings-as.component';

@NgModule({
  imports: [
    CommonModule,
    InvestigationFindingsAsRoutingModule
  ],
  declarations: [InvestigationFindingsAsComponent]
})
export class InvestigationFindingsAsModule { }
