import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PhoneCreateUpdateComponent } from './phone-create-update/phone-create-update.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { EmailCreateUpdateComponent } from './email-create-update/email-create-update.component';
import { SmartyStreetAddressComponent } from './smarty-street-address/smarty-street-address.component';
import { DocumentUploadListComponent } from './document-upload-list/document-upload-list.component';
import { AttachmentUploadComponent } from './attachment-upload/attachment-upload.component';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MatMenuModule } from '@angular/material/menu'
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    MatMenuModule,
    MatFormFieldModule,
    MatInputModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  providers:[provideNgxMask()],
  declarations: [PhoneCreateUpdateComponent, EmailCreateUpdateComponent, SmartyStreetAddressComponent, DocumentUploadListComponent,AttachmentUploadComponent],
  exports: [PhoneCreateUpdateComponent, EmailCreateUpdateComponent, SmartyStreetAddressComponent, DocumentUploadListComponent,AttachmentUploadComponent]
})
export class ShareFeaturesModule { }
