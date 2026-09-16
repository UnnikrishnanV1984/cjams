import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeReferralRoutingModule } from './intake-referral-routing.module';
import { IntakeReferralComponent } from './intake-referral.component';
import { IntakeReferralPersongridComponent } from './intake-referral-persongrid/intake-referral-persongrid.component';
import { IntakeReferralComplaintsgridComponent } from './intake-referral-complaintsgrid/intake-referral-complaintsgrid.component';
import { IntakeReferralAppointmentsgridComponent } from './intake-referral-appointmentsgrid/intake-referral-appointmentsgrid.component';
import { IntakeReferralCasegridComponent } from './intake-referral-casegrid/intake-referral-casegrid.component';
import { IntakeReferralAssesmentsgridComponent } from './intake-referral-assesmentsgrid/intake-referral-assesmentsgrid.component';

@NgModule({
  imports: [
    CommonModule,
    IntakeReferralRoutingModule
  ],
  declarations: [IntakeReferralComponent, IntakeReferralPersongridComponent, IntakeReferralComplaintsgridComponent, IntakeReferralAppointmentsgridComponent, IntakeReferralCasegridComponent, IntakeReferralAssesmentsgridComponent]
})
export class IntakeReferralModule { }
