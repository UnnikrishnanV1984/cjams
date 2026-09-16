import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OutOfHomePlacementRoutingModule } from './out-of-home-placement-routing.module';
import { OutOfHomePlacementComponent } from './out-of-home-placement.component';
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

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';

@NgModule({
  imports: [
    CommonModule,
    OutOfHomePlacementRoutingModule,
    MatCardModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatListModule,
    MatNativeDateModule,
    MatRadioModule,
    MatSelectModule,
    MatTableModule,
    MatTabsModule,
    // A2Edatetimepicker
  ],
  declarations: [OutOfHomePlacementComponent]
})
export class OutOfHomePlacementModule { }
