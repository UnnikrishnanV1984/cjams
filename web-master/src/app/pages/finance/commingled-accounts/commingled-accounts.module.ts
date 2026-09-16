import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common'; 
// import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
// import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatChipsModule } from '@angular/material/chips';
// import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
// import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
// import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
// import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
// import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
// import { MatTooltipModule } from '@angular/material/tooltip';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TimepickerModule } from 'ngx-bootstrap/timepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module'; 
import { CommingledAccountsComponent } from './commingled-accounts.component';
import { CommingledAccountsRoutingModule } from './commingled-accounts-routing.module';
import { InterestTransactionsComponent } from './interest-transactions/interest-transactions.component';
import { CommingledAccountsTabComponent } from './commingled-accounts/commingled-accounts.component';

@NgModule({
  imports: [
    CommonModule,
    MatDatepickerModule,
    // MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatRadioModule,
    MatTabsModule,
    // MatTooltipModule,
    MatCheckboxModule,
    // MatListModule,
    // MatCardModule,
    // MatTableModule,
    // MatExpansionModule,
    // MatChipsModule,
    // MatIconModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    TimepickerModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    SharedPipesModule,
    NgSelectModule,
    SortTableModule,
    // MatAutocompleteModule,
    CommingledAccountsRoutingModule
  ],
  declarations: [CommingledAccountsComponent, InterestTransactionsComponent, CommingledAccountsTabComponent]
})
export class CommingledAccountsModule { }
