import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { IntakeAttachmentsGenerateRoutingModule } from './intake-attachments-generate-routing.module';
import { IntakeAttachmentsGenerateComponent } from './intake-attachments-generate.component';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { NgSelectModule } from '@ng-select/ng-select';

@NgModule({
  imports: [
    CommonModule,
    IntakeAttachmentsGenerateRoutingModule,
    FormMaterialModule,
    NgSelectModule
  ],
  declarations: [IntakeAttachmentsGenerateComponent]
})
export class IntakeAttachmentsGenerateModule { }
