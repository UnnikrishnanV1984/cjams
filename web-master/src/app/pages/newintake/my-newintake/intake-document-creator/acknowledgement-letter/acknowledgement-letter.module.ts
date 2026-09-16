import { CommonModule } from "@angular/common";
import { AcknowledgementLetterComponent } from "./acknowledgement-letter.component";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule } from "@angular/material/input";
import { MatTooltipModule } from "@angular/material/tooltip";
import { MatMenuModule } from "@angular/material/menu";

@NgModule({
  declarations: [AcknowledgementLetterComponent],
  exports: [AcknowledgementLetterComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule, MatFormFieldModule, MatInputModule, MatTooltipModule, MatMenuModule, ReactiveFormsModule]
})
export class AcknowledgementLetterModule {}