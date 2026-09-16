import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SubsidyRateRoutingModule } from './subsidy-rate-routing.module';
import { SubsidyRateComponent } from './subsidy-rate.component';
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
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { GoogleMapsModule } from '@angular/google-maps';

import { QuillModule } from 'ngx-quill';
import { ControlMessagesModule } from '../../../../../../../shared/modules/control-messages/control-messages.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { FiscalAuditModule } from '../../../../../../finance/fiscal-audit/fiscal-audit.module';
import { FinanceService } from '../../../../../../finance/finance.service';
import { SharedDirectivesModule } from '../../../../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    SubsidyRateRoutingModule,
    MatFormFieldModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    PaginationModule,
    MatExpansionModule,
    MatCardModule,
    MatListModule,
    MatNativeDateModule,
    MatRadioModule,
    MatTableModule,
    MatTabsModule,
    QuillModule.forRoot(),
    ControlMessagesModule,
    FormMaterialModule,
    SharedDirectivesModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    GoogleMapsModule,
    FiscalAuditModule
  ],
  declarations: [SubsidyRateComponent],
  providers: [FinanceService]
})
export class SubsidyRateModule { }
