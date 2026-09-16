import { CustomInfoTooltip } from "./custom-info-tooltip.component";
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms";

@NgModule({
  declarations: [CustomInfoTooltip],
  exports: [CustomInfoTooltip],
  imports: [FormsModule]
})
export class CustomInfoTooltipModule {}