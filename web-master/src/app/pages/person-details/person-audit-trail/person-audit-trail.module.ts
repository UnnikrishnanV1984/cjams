import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonAuditTrailRoutingModule } from './person-audit-trail-routing.module';
import { PersonAuditTrailComponent } from './person-audit-trail.component';
import { PersonAuditLogService } from './person-audit-log.service';
import { PersonAuditLogResolverService } from './person-audit-log-resolver.service';
import { FormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatSelectModule } from '@angular/material/select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    PersonAuditTrailRoutingModule,
    MatSelectModule,
    FormsModule,
    SharedPipesModule,
    PaginationModule
  ],
  declarations: [PersonAuditTrailComponent],
  providers: [PersonAuditLogService, PersonAuditLogResolverService]
})
export class PersonAuditTrailModule { }
