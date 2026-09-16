import { CommonModule } from "@angular/common";
import { CustomTableActionsComponent } from "./custom-table-actions.component";
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";

@NgModule({
  declarations: [CustomTableActionsComponent],
  exports: [CustomTableActionsComponent],
  imports: [CommonModule, FormsModule, MatCheckboxModule]
})
export class CustomTableActionsModule {}