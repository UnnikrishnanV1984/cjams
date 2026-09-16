import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

import { PersonMergeRoutingModule } from './person-merge-routing.module';
import { PersonMergeComponent } from './person-merge.component';

@NgModule({
  imports: [
    CommonModule,
    PersonMergeRoutingModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [PersonMergeComponent]
})
export class PersonMergeModule { }
