import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ClientPaymentRoutingModule } from './client-payment-routing.module';
import { ClientPaymentComponent } from './client-payment.component';
import { ClientPaymentDetailsComponent } from './client-payment-details/client-payment-details.component';
import { ClientPaymentResultComponent } from './client-payment-result/client-payment-result.component';
import { ClientPaymentSearchComponent } from './client-payment-search/client-payment-search.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';

@NgModule({
  imports: [
    CommonModule,
    ClientPaymentRoutingModule,
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
    MatRippleModule,
    MatButtonModule,
    MatRadioModule,
    SortTableModule
  ],
  declarations: [ClientPaymentComponent, ClientPaymentDetailsComponent, ClientPaymentResultComponent, ClientPaymentSearchComponent]
})
export class ClientPaymentModule { }
