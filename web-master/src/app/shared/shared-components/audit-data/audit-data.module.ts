import { CommonModule } from "@angular/common";
import { AuditDataComponent } from "./audit-data.component";
import { NgModule } from "@angular/core";
import { PaginationModule } from "ngx-bootstrap/pagination";
import { FormsModule } from "@angular/forms";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CustomInfoTooltipModule } from "../custom-info-tooltip/custom-info-tooltip.module";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { CustomSearchModule } from "../custom-search/custom-search.module";
import { SortTableModule } from "../../modules/sortable-table/sortable-table.module";

@NgModule({
  declarations: [AuditDataComponent],
  exports: [AuditDataComponent],
  imports: [CommonModule, PaginationModule, FormsModule, MatTooltipModule, CustomInfoTooltipModule, MatCheckboxModule, CustomSearchModule, SortTableModule]
})
export class AuditDataModule {}