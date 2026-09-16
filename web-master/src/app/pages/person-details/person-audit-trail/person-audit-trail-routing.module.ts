import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonAuditTrailComponent } from './person-audit-trail.component';
import { PersonAuditLogResolverService } from './person-audit-log-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: PersonAuditTrailComponent,
    resolve: {
      auditLogs : PersonAuditLogResolverService
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonAuditTrailRoutingModule { }
