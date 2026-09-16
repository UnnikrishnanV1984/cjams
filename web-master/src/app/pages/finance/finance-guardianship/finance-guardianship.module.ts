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
import { FinanceGuardianshipRoutingModule } from './finance-guardianship-routing.module';
import { FinanceGuardianshipSearchFiltersComponent } from './finance-guardianship-search-filters/finance-guardianship-search-filters.component';
import { FinanceGuardianshipSearchResultComponent } from './finance-guardianship-search-result/finance-guardianship-search-result.component';
import { FinanceGuardianshipSearchViewComponent } from './finance-guardianship-search-view/finance-guardianship-search-view.component';
import { FinanceGuardianshipComponent } from './finance-guardianship.component';


@NgModule({
  imports: [
    CommonModule,
    FinanceGuardianshipRoutingModule,
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
  declarations: [FinanceGuardianshipComponent, FinanceGuardianshipSearchFiltersComponent, FinanceGuardianshipSearchResultComponent, FinanceGuardianshipSearchViewComponent]
})
export class FinanceGuardianshipModule { }
