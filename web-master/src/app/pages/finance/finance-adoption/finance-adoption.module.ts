import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { FinanceAdoptionRoutingModule } from './finance-adoption-routing.module';
import { FinanceAdoptionSearchFiltersComponent } from './finance-adoption-search-filters/finance-adoption-search-filters.component';
import { FinanceAdoptionSearchResultComponent } from './finance-adoption-search-result/finance-adoption-search-result.component';
import { FinanceAdoptionSearchViewComponent } from './finance-adoption-search-view/finance-adoption-search-view.component';
import { FinanceAdoptionComponent } from './finance-adoption.component';


@NgModule({
  imports: [
    CommonModule,
    FinanceAdoptionRoutingModule,
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
  declarations: [FinanceAdoptionComponent, FinanceAdoptionSearchFiltersComponent, FinanceAdoptionSearchResultComponent, FinanceAdoptionSearchViewComponent]
})
export class FinanceAdoptionModule { }
