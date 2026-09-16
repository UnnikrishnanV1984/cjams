import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ReportSummaryDjsComponent } from './report-summary-djs.component';
const routes: Routes = [
    {
    path: '',
    component: ReportSummaryDjsComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReportSummaryDjsRoutingModule { }
