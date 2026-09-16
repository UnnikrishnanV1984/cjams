import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
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
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { FosterCareRoutingModule } from './foster-care-routing.module';
import { FosterCareComponent } from './foster-care.component';
import { FosterCareSearchComponent } from './foster-care-search/foster-care-search.component';
import { FosterCareListComponent } from './foster-care-list/foster-care-list.component';
import { FosterCareReferalComponent } from './foster-care-referal/foster-care-referal.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { GoogleMapsModule } from '@angular/google-maps';

import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    FosterCareRoutingModule,
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
    // A2Edatetimepicker,
    FormsModule,
    ReactiveFormsModule,
    GoogleMapsModule,
    SharedDirectivesModule,
    PaginationModule
    // Title4eModule
  ],
  declarations: [FosterCareComponent, FosterCareSearchComponent, FosterCareListComponent, FosterCareReferalComponent],
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class FosterCareModule { }
