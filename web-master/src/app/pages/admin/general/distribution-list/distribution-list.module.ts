import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { DistributionListRoutingModule } from './distribution-list-routing.module';
import { DistributionListComponent } from './distribution-list.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    DistributionListRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [DistributionListComponent]
})
export class DistributionListModule { }
