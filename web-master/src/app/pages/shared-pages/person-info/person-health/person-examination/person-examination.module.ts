import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonExaminationRoutingModule } from './person-examination-routing.module';
import { ExaminationCwComponent } from './examination-cw/examination-cw.component';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { ExaminationAppointmentCreateComponent } from './examination-cw/examination-appointment-create/examination-appointment-create.component';
import { PersonExaminationService } from './person-examination.service';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
// import { SharedComponentsModule } from '../../../../../shared/shared-components/shared-components.module';
import { ShareFeaturesModule } from '../../share-features/share-features.module';
import { DocumentUploadListSharedModule } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
@NgModule({
  imports: [
    CommonModule,
    PersonExaminationRoutingModule,
    FormMaterialModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    //  SharedComponentsModule,
    ShareFeaturesModule,
    NgxMaskDirective,
    NgxMaskPipe,
    DocumentUploadListSharedModule,
    AttachmentUploadsharedModule

  ],
  declarations: [
    ExaminationCwComponent,
    ExaminationAppointmentCreateComponent

  ],
  providers: [PersonExaminationService,provideNgxMask()]

})
export class PersonExaminationModule { }