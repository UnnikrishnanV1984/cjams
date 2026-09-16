import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonAlertsRoutingModule } from './person-alerts-routing.module';
import { PersonAlertsComponent } from './person-alerts.component';
import { PersonAlertListComponent } from './person-alert-list/person-alert-list.component';
import { PersonAlertDetailsComponent } from './person-alert-details/person-alert-details.component';
import { QuillModule } from 'ngx-quill';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    PersonAlertsRoutingModule,
    QuillModule.forRoot(),
    MatDatepickerModule,
    MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatRadioModule,
    MatTabsModule,
    MatCheckboxModule,
    MatListModule,
    MatCardModule,
    MatTableModule,
    FormsModule,
    ReactiveFormsModule,
    MatExpansionModule,
    PaginationModule
  ],
  declarations: [PersonAlertsComponent, PersonAlertListComponent, PersonAlertDetailsComponent]
})
export class PersonAlertsModule { }
