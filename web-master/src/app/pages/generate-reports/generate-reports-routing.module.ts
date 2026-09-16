import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GenerateReportsComponent } from './generate-reports.component';
import { CcuCaseReportComponent } from './ccu-case-report/ccu-case-report.component';
import { NewCaseReportComponent } from './new-case-report/new-case-report.component';
import { ExceptionReportComponent } from './exception-report/exception-report.component';
import { BalanceSheetComponent } from './balance-sheet/balance-sheet.component';
import { LevelReportComponent } from './level-report/level-report.component';
import { CourtlistReportComponent } from './courtlist-report/courtlist-report.component';
import { CensusReportComponent } from './census-report/census-report.component';

const routes: Routes = [
  {
    path: '',
    component: GenerateReportsComponent,
    children: [
      {
        path: 'ccu',
        component: CcuCaseReportComponent
      },
      {
        path: 'new-case',
        component: NewCaseReportComponent
      },
      {
        path: 'exception',
        component: ExceptionReportComponent
      },
      {
        path: 'balance-sheet',
        component: BalanceSheetComponent
      },
      {
        path: 'level-report',
        component: LevelReportComponent
      },
      {
        path: 'courtlist-report',
        component: CourtlistReportComponent
      },
      {
        path: 'census-report',
        component: CensusReportComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GenerateReportsRoutingModule { }
