import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PsychotropicPrescriptionReviewRoutingModule } from './psychotropicprescription-review-routing.module';
import { PsychotropicprescriptionReviewComponent } from './psychotropicprescription-review.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FormMaterialModule } from '../../@core/form-material.module';
// import { SharedComponentsModule } from '../../shared/shared-components/shared-components.module';
import { provideNgxMask, NgxMaskDirective, NgxMaskPipe } from 'ngx-mask';
import { DsdsService } from '../case-worker/dsds-action/_services/dsds.service';
import { CustomTableModule } from '../../shared/shared-components/custom-table/custom-table.module';
import { AttachmentUploadsharedModule } from '../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { DocumentUploadListSharedModule } from '../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { MatMenuModule } from '@angular/material/menu';

@NgModule({
  declarations: [PsychotropicprescriptionReviewComponent],
  imports: [
    PsychotropicPrescriptionReviewRoutingModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    FormMaterialModule,
    // SharedComponentsModule,
    NgxMaskDirective,
    NgxMaskPipe,
    CustomTableModule,
    AttachmentUploadsharedModule,
    DocumentUploadListSharedModule,
    MatMenuModule

  ],
  providers: [DsdsService, provideNgxMask()]
})
export class PsychotropicprescriptionReviewModule { }