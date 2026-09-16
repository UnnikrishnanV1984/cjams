import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SsiSsaTrackingRoutingModule } from './ssi-ssa-tracking-routing.module';
import { SsiSsaTrackingComponent } from './ssi-ssa-tracking.component';
import { SsiSsaSearchComponent } from './ssi-ssa-search/ssi-ssa-search.component';
import { SsiSsaSearchResultComponent } from './ssi-ssa-search-result/ssi-ssa-search-result.component';
import { SsiSsaOverviewComponent } from './ssi-ssa-overview/ssi-ssa-overview.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';

@NgModule({
  imports: [
    CommonModule,
    SsiSsaTrackingRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    // MatRippleModule,
    MatButtonModule,
    MatRadioModule,
    MatAutocompleteModule

  ],
  declarations: [SsiSsaTrackingComponent, SsiSsaSearchComponent, SsiSsaSearchResultComponent, SsiSsaOverviewComponent]
})
export class SsiSsaTrackingModule { }
