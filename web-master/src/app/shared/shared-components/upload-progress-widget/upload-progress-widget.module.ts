import { CommonModule } from "@angular/common";
import { UploadProgressWidgetComponent } from "./upload-progress-widget.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CommonControlsModule } from "../../modules/common-controls/common-controls.module";
import { MatMenuModule } from "@angular/material/menu";
import { DragDropModule } from "@angular/cdk/drag-drop";

@NgModule({
  declarations: [UploadProgressWidgetComponent],
  exports: [UploadProgressWidgetComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, CommonControlsModule, MatMenuModule, ReactiveFormsModule, DragDropModule]
})
export class UploadProgressWidgetModule {}