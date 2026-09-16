import { FinancePlacementComponent } from './finance-placement.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { FinancePlacementRoutingModule } from './finance-placement-routing.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FinancePlacementSearchFiltersComponent } from './finance-placement-search-filters/finance-placement-search-filters.component';
import { FinancePlacementSearchResultComponent } from './finance-placement-search-result/finance-placement-search-result.component';
import { FinancePlacementSearchViewComponent } from './finance-placement-search-view/finance-placement-search-view.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';

@NgModule({
  imports: [
    CommonModule,
    FinancePlacementRoutingModule,
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
    MatButtonModule
  ],
  declarations: [FinancePlacementComponent, FinancePlacementSearchFiltersComponent, FinancePlacementSearchResultComponent, FinancePlacementSearchViewComponent]
})
export class FinancePlacementModule { }
