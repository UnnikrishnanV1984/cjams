import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonProbationRoutingModule } from './person-probation-routing.module';
import { PersonProbationComponent } from './person-probation.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    MatDatepickerModule,
    MatInputModule,
    MatSelectModule,
    MatRadioModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    PersonProbationRoutingModule
  ],
  declarations: [PersonProbationComponent]
})
export class PersonProbationModule { }
