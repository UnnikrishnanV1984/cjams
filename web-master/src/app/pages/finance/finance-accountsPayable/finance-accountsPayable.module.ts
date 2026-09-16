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
// import { MatTooltipModule } from '@angular/material/tooltip';
import { FinanceAccountsPayableRoutingModule } from './finance-accountsPayable-routing.module';
import { FinanceAccountsPayableSearchFiltersComponent } from './finance-accountsPayable-search-filters/finance-accountsPayable-search-filters.component';
import { FinanceAccountsPayableSearchResultComponent } from './finance-accountsPayable-search-result/finance-accountsPayable-search-result.component';
import { FinanceAccountsPayableSearchViewComponent } from './finance-accountsPayable-search-view/finance-accountsPayable-search-view.component';
import { FinanceAccountsPayableComponent } from './finance-accountsPayable.component';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { FinanceService } from '../finance.service';
import { ProviderInfoPopupModule } from '../provider-info-popup/provider-info-popup.module';

@NgModule({
  imports: [
    CommonModule,
    FinanceAccountsPayableRoutingModule,
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
    SortTableModule,
    // MatTooltipModule,
    ProviderInfoPopupModule
  ],
  // tslint:disable-next-line:max-line-length
  declarations: [FinanceAccountsPayableComponent, FinanceAccountsPayableSearchFiltersComponent, FinanceAccountsPayableSearchResultComponent, FinanceAccountsPayableSearchViewComponent],
  providers: [FinanceService]
})
export class FinanceAccountsPayableModule { }
