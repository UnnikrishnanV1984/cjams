import { PersonsComponent } from './persons.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatFormFieldModule } from '@angular/material/form-field';

import { PersonsRoutingModule } from './persons-routing.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PersonSearchFiltersComponent } from './person-search-filters/person-search-filters.component';
import { PersonSearchResultComponent } from './person-search-result/person-search-result.component';
import { PersonSearchViewComponent } from './person-search-view/person-search-view.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { MatDatepickerModule } from '@angular/material/datepicker';

@NgModule({
  imports: [
    CommonModule,
    PersonsRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatFormFieldModule
  ],
  declarations: [PersonsComponent, PersonSearchFiltersComponent, PersonSearchResultComponent, PersonSearchViewComponent]
})
export class PersonsModule { }
