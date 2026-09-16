import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonOtherAgenciesRoutingModule } from './person-other-agencies-routing.module';
import { PersonOtherAgenciesComponent } from './person-other-agencies.component';

@NgModule({
  imports: [
    CommonModule,
    PersonOtherAgenciesRoutingModule
  ],
  declarations: [PersonOtherAgenciesComponent]
})
export class PersonOtherAgenciesModule { }
