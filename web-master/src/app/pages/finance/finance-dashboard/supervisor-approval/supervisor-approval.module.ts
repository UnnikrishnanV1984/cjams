import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SupervisorApprovalRoutingModule } from './supervisor-approval-routing.module';
import { SupervisorApprovalComponent } from './supervisor-approval.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    SupervisorApprovalRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    MatTooltipModule,
    MatSelectModule,
    SharedPipesModule
  ],
  declarations: [SupervisorApprovalComponent] 
})
export class SupervisorApprovalModule { }
