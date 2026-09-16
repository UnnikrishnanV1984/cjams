import { CommonModule } from "@angular/common";
import { ScanSharedAttachementComponent } from "./scan-shared-attachement.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CommonControlsModule } from "../../modules/common-controls/common-controls.module";
import { MatMenuModule } from "@angular/material/menu";
import { AttachementScanDetailModule } from "../attachement-scan-detail/attachement-scan-detail.module";

@NgModule({
  declarations: [ScanSharedAttachementComponent],
  exports: [ScanSharedAttachementComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, CommonControlsModule, MatMenuModule, ReactiveFormsModule, AttachementScanDetailModule]
})
export class ScanSharedAttachementModule {}