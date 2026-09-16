import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
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
 

import { ApEmotionalTilesRoutingModule } from './ap-emotional-tiles-routing.module';
import { ApEmotionalTilesComponent } from './ap-emotional-tiles.component';
import { ReactiveFormsModule } from '@angular/forms';
import { GoogleMapsModule } from '@angular/google-maps';

import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';
import { ControlMessagesModule } from '../../../../../../../shared/modules/control-messages/control-messages.module';

@NgModule({
  imports: [
    CommonModule,
    ApEmotionalTilesRoutingModule,
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
    ControlMessagesModule,
    FormMaterialModule,
    ReactiveFormsModule,
    PaginationModule,
    GoogleMapsModule
  ],
  declarations: [ApEmotionalTilesComponent]
})
export class ApEmotionalTilesModule { }
