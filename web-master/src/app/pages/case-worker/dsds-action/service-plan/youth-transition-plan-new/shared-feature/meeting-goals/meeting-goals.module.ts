import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MeetingGoalsComponent } from './meeting-goals.component';
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule
  ],
  declarations: [MeetingGoalsComponent],
  exports: [MeetingGoalsComponent]
})
export class MeetingGoalsModule { }
