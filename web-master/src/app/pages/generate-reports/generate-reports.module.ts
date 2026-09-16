import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GenerateReportsRoutingModule } from './generate-reports-routing.module';
import { GenerateReportsComponent } from './generate-reports.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FormMaterialModule } from '../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { GenerateReportsService } from './generate-reports.service';
import { CcuCaseReportComponent } from './ccu-case-report/ccu-case-report.component';
import { NewCaseReportComponent } from './new-case-report/new-case-report.component';
import { ExceptionReportComponent } from './exception-report/exception-report.component';
import { BalanceSheetComponent } from './balance-sheet/balance-sheet.component';
import { LevelReportComponent } from './level-report/level-report.component';
import { CourtlistReportComponent } from './courtlist-report/courtlist-report.component';
import { CensusReportComponent } from './census-report/census-report.component';

@NgModule({
  imports: [
    CommonModule,
    GenerateReportsRoutingModule,
    MatSelectModule,
    FormsModule,
    MatCheckboxModule,
    ReactiveFormsModule,
    FormMaterialModule,
    PaginationModule
  ],
  declarations: [GenerateReportsComponent, CcuCaseReportComponent, NewCaseReportComponent, ExceptionReportComponent, BalanceSheetComponent, LevelReportComponent, CourtlistReportComponent, CensusReportComponent],
  providers: [GenerateReportsService]
})
export class GenerateReportsModule { }
