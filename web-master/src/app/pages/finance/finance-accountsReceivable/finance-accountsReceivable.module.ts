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
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { FinanceAccountsReceivableRoutingModule } from './finance-accountsReceivable-routing.module';
import { FinanceAccountsReceivableSearchFiltersComponent } from './finance-accountsReceivable-search-filters/finance-accountsReceivable-search-filters.component';
import { FinanceAccountsReceivableSearchResultComponent } from './finance-accountsReceivable-search-result/finance-accountsReceivable-search-result.component';
import { FinanceAccountsReceivableSearchViewComponent } from './finance-accountsReceivable-search-view/finance-accountsReceivable-search-view.component';
import { FinanceAccountsReceivableComponent } from './finance-accountsReceivable.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';


@NgModule({
  imports: [
    CommonModule,
    FinanceAccountsReceivableRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SortTableModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    // MatRippleModule,
    MatButtonModule,
    MatRadioModule,
    SharedPipesModule
  ],
  declarations: [FinanceAccountsReceivableComponent, FinanceAccountsReceivableSearchFiltersComponent, FinanceAccountsReceivableSearchResultComponent, FinanceAccountsReceivableSearchViewComponent]
})
export class FinanceAccountsReceivableModule { }
