import { CommonModule } from "@angular/common";
import { HospitalizationCwSharedComponent } from "./hospitalization-cw-shared.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CommonControlsModule } from "../../modules/common-controls/common-controls.module";
import { MatMenuModule } from "@angular/material/menu";
import { MatSelectModule } from "@angular/material/select";
import { MatRadioModule } from "@angular/material/radio";
import { PaginationModule } from "ngx-bootstrap/pagination";
import { DocumentUploadListSharedModule } from "../document-upload-list-shared/document-upload-list-shared.module";
import { AttachmentUploadsharedModule } from "../attachment-upload-shared/attachment-upload-shared.module";
import { ShareFeaturesModule } from "../../../pages/shared-pages/person-info/share-features/share-features.module";
import { MatAutocompleteModule } from "@angular/material/autocomplete";
import { PopoverModule } from "ngx-bootstrap/popover";
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';

@NgModule({
  declarations: [HospitalizationCwSharedComponent],
  exports: [HospitalizationCwSharedComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, CommonControlsModule, MatMenuModule, ReactiveFormsModule, MatSelectModule, MatRadioModule, PaginationModule, DocumentUploadListSharedModule, AttachmentUploadsharedModule, ShareFeaturesModule, MatAutocompleteModule, PopoverModule, NgxMaskDirective,NgxMaskPipe ],
  providers: [provideNgxMask()]
})
export class HospitalizationCwSharedModule {}