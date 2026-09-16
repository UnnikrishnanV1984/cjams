import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ArProviderHistoryRoutingModule } from './ar-provider-history-routing.module';
import { ArProviderHistoryComponent } from './ar-provider-history.component';
import { HistoryOverpaymentsComponent } from './history-overpayments/history-overpayments.component';
import { OffsetReceiptComponent } from './offset-receipt/offset-receipt.component';
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
import { MatTooltipModule } from '@angular/material/tooltip';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { ArProviderHistoryService } from './ar-provider-history.service';
import { CommonControlsModule } from '../../../../../shared/modules/common-controls/common-controls.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
@NgModule({
  imports: [
    CommonModule,
    ArProviderHistoryRoutingModule,
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
    PaginationModule,
    FormsModule,
    ReactiveFormsModule,
    MatTooltipModule,
    CommonControlsModule,
    SharedPipesModule
  ],
  declarations: [ArProviderHistoryComponent, HistoryOverpaymentsComponent, OffsetReceiptComponent],
  providers: [FinanceArProviderDetailsService, ArProviderHistoryService]
})
export class ArProviderHistoryModule { }
