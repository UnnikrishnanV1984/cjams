import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeDecisionRoutingModule } from './intake-decision-routing.module';
import { IntakeDecisionComponent } from './intake-decision.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatTooltipModule } from '@angular/material/tooltip';
import { QuillModule } from 'ngx-quill';
import { IntakeDecisionResolverService } from './intake-decision-resolver.service';


@NgModule({
  imports: [
    CommonModule,
    IntakeDecisionRoutingModule,
    FormMaterialModule,
    PaginationModule,
    MatTooltipModule,
    QuillModule.forRoot(),
  ],
  declarations: [IntakeDecisionComponent],
  providers: [IntakeDecisionResolverService]
})
export class IntakeDecisionModule { }
