import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatRadioModule } from '@angular/material/radio';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { ProviderPaymentMgmtComponent } from './provider-payment-management.component';
import { ProviderPaymentMgmtRoutingModule } from './provider-payment-management-routing.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatTabsModule } from '@angular/material/tabs';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { MatListModule } from '@angular/material/list';
import { MatCardModule } from '@angular/material/card';
import { MatExpansionModule } from '@angular/material/expansion';
import { GoogleMapsModule } from '@angular/google-maps';

import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';

@NgModule({
  imports: [
    CommonModule,
    ProviderPaymentMgmtRoutingModule,
    MatTabsModule,
    MatSelectModule,
    MatTableModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatInputModule,
    MatCheckboxModule,
    MatAutocompleteModule,
    ReactiveFormsModule,
    FormsModule,
    PaginationModule,
    // A2Edatetimepicker,
     NgSelectModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    MatDatepickerModule,
    MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatRadioModule,
    MatTabsModule,
    MatCheckboxModule,
    MatListModule,
    MatCardModule,
    MatTableModule,
    MatExpansionModule,
    // AgmCoreModule
    GoogleMapsModule,
    SharedDirectivesModule,
    SortTableModule,
    PaginationModule.forRoot(),
    NgxMaskDirective,
    NgxMaskPipe

  ],
  providers:[provideNgxMask()],
  declarations: [
    ProviderPaymentMgmtComponent
  ]
})
export class ProviderPaymentMgmtModule { }
