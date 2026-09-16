// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PlanRoutingModule } from './plan-routing.module';
import { PlanComponent } from './plan.component';
import { SafetyPlanComponent } from './safety-plan/safety-plan.component';
import { ServicePlanComponent } from './service-plan/service-plan.component';
import { ServiceLogComponent } from './service-log/service-log.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { SafetyPlanHistoryComponent } from './safety-plan-history/safety-plan-history.component';
import { SafetyPlanPrintViewComponent } from './safety-plan-print-view/safety-plan-print-view.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';
import { SignatureFieldComponent } from './safety-plan/signature-field/signature-field.component';


@NgModule({
  imports: [
    CommonModule,
    PlanRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    // A2Edatetimepicker,
    MatDatepickerModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatCheckboxModule,
    AngularSignaturePadModule
  ],
  declarations: [PlanComponent, SafetyPlanComponent, ServicePlanComponent, ServiceLogComponent, SafetyPlanHistoryComponent, SafetyPlanPrintViewComponent, SignatureFieldComponent]
})
export class PlanModule { }
