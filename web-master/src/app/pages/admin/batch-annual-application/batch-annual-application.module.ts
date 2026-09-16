import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';


import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { BatchAnnualApplicationRoutingModule } from './batch-annual-application-routing.module';
import { BatchAnnualApplicationComponent } from './batch-annual-application.component';


@NgModule({
  imports: [
    CommonModule,
    BatchAnnualApplicationRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    ControlMessagesModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [BatchAnnualApplicationComponent]
})
export class BatchAnnualApplicationModule { }
