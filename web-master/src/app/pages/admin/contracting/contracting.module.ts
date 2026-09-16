import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { ContractingRoutingModule } from './contracting-routing.module';
import { ContractingComponent } from './contracting.component';

@NgModule({
  imports: [
    CommonModule,
    ContractingRoutingModule, ReactiveFormsModule, FormsModule, ControlMessagesModule,
    NgSelectModule, SharedPipesModule
  ],
  declarations: [ContractingComponent]
})
export class ContractingModule { }
