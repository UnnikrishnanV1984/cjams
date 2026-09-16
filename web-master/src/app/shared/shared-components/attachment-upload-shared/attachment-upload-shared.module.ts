import { CommonModule } from "@angular/common";
import { AttachmentUploadSharedComponent } from "./attachment-upload-shared.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CommonControlsModule } from "../../modules/common-controls/common-controls.module";
import { MatMenuModule } from "@angular/material/menu";
import { EditAttachmentSharedModule } from "../edit-attachment-shared/edit-attachment-shared.module";
import { PaginationModule } from "ngx-bootstrap/pagination";
import { NgxfUploaderService, NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';

@NgModule({
  declarations: [AttachmentUploadSharedComponent],
  exports: [AttachmentUploadSharedComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, CommonControlsModule, MatMenuModule, ReactiveFormsModule, EditAttachmentSharedModule, PaginationModule, NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective],
  providers:[NgxfUploaderService]
})
export class AttachmentUploadsharedModule {}