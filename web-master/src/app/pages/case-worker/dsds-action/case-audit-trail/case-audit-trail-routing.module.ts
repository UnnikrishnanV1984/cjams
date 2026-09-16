import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseAuditTrailComponent  } from './case-audit-trail.component';

const routes: Routes = [{
  path: '',
  component: CaseAuditTrailComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaseAuditTrailRoutingModule { }