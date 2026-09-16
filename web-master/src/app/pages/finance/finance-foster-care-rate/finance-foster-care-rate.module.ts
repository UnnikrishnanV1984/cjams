import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinanceFosterCareRateRoutingModule } from './finance-foster-care-rate-routing.module';
import { FinanceFosterCareRateComponent } from './finance-foster-care-rate.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
// import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
// import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    FinanceFosterCareRateRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // MatCardModule,
    MatCheckboxModule,
    MatDatepickerModule,
    // MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    // MatListModule,
    // MatNativeDateModule,
    MatRadioModule,
    MatSelectModule,
    MatTableModule,
    MatTabsModule,
      NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    SortTableModule,
    SharedPipesModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  providers:[provideNgxMask()],
  declarations: [FinanceFosterCareRateComponent]
})
export class FinanceFosterCareRateModule { }
