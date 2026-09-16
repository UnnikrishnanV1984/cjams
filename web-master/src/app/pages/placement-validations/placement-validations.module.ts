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

import { PlacementValidationsRoutingModule } from './placement-validations-routing.module';
import { PlacementValidationsComponent } from './placement-validations.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PendingPlacementComponent } from './pending-placement/pending-placement.component';
import { ApprovedPlacementComponent } from './approved-placement/approved-placement.component';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { FormMaterialModule } from '../../@core/form-material.module';
import { SortTableModule } from './../../shared/modules/sortable-table/sortable-table.module';
import { PlacementValidationsResolverService } from './placement-validations-resolver-service';

@NgModule({
  imports: [
    CommonModule,
    PlacementValidationsRoutingModule,
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
    PaginationModule,
    FormMaterialModule,
    SortTableModule
  ],
  declarations: [PlacementValidationsComponent, PendingPlacementComponent, ApprovedPlacementComponent],
  providers: [IntakeUtils, PlacementValidationsResolverService]
})
export class PlacementValidationsModule { }
