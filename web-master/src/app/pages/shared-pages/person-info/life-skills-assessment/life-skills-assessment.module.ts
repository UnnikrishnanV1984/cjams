import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LifeSkillsAssessmentRoutingModule } from './life-skills-assessment-routing.module';
import { LifeSkillsAssessmentComponent } from './life-skills-assessment.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    LifeSkillsAssessmentRoutingModule,
    FormMaterialModule,
    PaginationModule
  ],
  declarations: [LifeSkillsAssessmentComponent]
})
export class LifeSkillsAssessmentModule { }
