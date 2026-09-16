import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ReportSummaryComponent } from './report-summary.component';
import { ReportSummaryResolverService } from './report-summary-resolver-service';
const routes: Routes = [
  {
    path: '',
    component: ReportSummaryComponent,
    resolve: {
      result: ReportSummaryResolverService
    }
  },
  {
    path: 'report-summary',
    component: ReportSummaryComponent,
    resolve: {
      result: ReportSummaryResolverService
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportSummaryRoutingModule { }
