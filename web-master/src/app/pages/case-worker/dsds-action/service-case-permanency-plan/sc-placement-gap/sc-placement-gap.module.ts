import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';

import { ScPlacementGapRoutingModule } from './sc-placement-gap-routing.module';
import { ScPlacementGapComponent } from './sc-placement-gap.component';
import { ScDisclosureChecklistComponent } from './sc-disclosure-checklist/sc-disclosure-checklist.component';
import { ScAgreementComponent } from './sc-agreement/sc-agreement.component';

@NgModule({
  imports: [
    CommonModule,
    ScPlacementGapRoutingModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatRadioModule,
    MatSelectModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [ScPlacementGapComponent, ScDisclosureChecklistComponent, ScAgreementComponent]
})
export class ScPlacementGapModule { }
