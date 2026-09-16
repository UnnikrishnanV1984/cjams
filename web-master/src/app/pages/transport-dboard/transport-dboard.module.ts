import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TransportDboardRoutingModule } from './transport-dboard-routing.module';
import { TransportDboardComponent } from './transport-dboard.component';
import { TransportListComponent } from './transport-list/transport-list.component';
import { TransportRosterComponent } from './transport-roster/transport-roster.component';
import { ReactiveFormsModule } from '@angular/forms';
import { CommonControlsModule } from '../../shared/modules/common-controls/common-controls.module';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
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
@NgModule({
  imports: [
    CommonModule,
    TransportDboardRoutingModule,
    ReactiveFormsModule,
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
    MatExpansionModule,
    MatAutocompleteModule,
    CommonControlsModule
  ],
  declarations: [TransportDboardComponent, TransportListComponent, TransportRosterComponent]
})
export class TransportDboardModule { }
