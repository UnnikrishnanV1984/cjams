import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { KinshipRoutingModule } from './kinship-routing.module';
import { KinshipComponent } from './kinship.component';
import { CaseApprovalComponent } from './case-approval/case-approval.component';
import { KinshipReferralComponent } from './kinship-referral/kinship-referral.component';
import { KinshipAssessmentComponent } from './kinship-assessment/kinship-assessment.component';
import { ServiceCaseComponent } from './service-case/service-case.component';
import { CaseClosureComponent } from './case-closure/case-closure.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';

@NgModule({
    imports: [CommonModule, ReactiveFormsModule, KinshipRoutingModule, MatCheckboxModule, MatDatepickerModule, MatFormFieldModule, MatInputModule, MatSelectModule, MatExpansionModule, MatRadioModule,SharedDirectivesModule],
    declarations: [KinshipComponent, CaseApprovalComponent, KinshipReferralComponent, KinshipAssessmentComponent, ServiceCaseComponent, CaseClosureComponent]
})
export class KinshipModule {}
