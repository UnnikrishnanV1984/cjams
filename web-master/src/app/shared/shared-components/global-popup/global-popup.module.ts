import { CommonModule } from "@angular/common";
import { GlobalPopupComponent } from "./global-popup.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CommonControlsModule } from "../../modules/common-controls/common-controls.module";
import { MatMenuModule } from "@angular/material/menu";
import { MatRadioModule } from "@angular/material/radio";
import { MatButtonModule } from "@angular/material/button";
import { MatSelectModule } from "@angular/material/select";

@NgModule({
  declarations: [GlobalPopupComponent],
  exports: [GlobalPopupComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, CommonControlsModule, MatMenuModule, ReactiveFormsModule, MatRadioModule, MatButtonModule, MatSelectModule ]
})
export class GlobalPopupModule {}