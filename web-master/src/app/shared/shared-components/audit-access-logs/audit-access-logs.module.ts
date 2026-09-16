import { CommonModule } from "@angular/common";
import { AuditAccessLogsComponent } from "./audit-access-logs.component";
import { NgModule } from "@angular/core";
import { PaginationModule } from "ngx-bootstrap/pagination";
import { FormsModule } from "@angular/forms";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CustomTableModule } from "../custom-table/custom-table.module";
import { MatCheckboxModule } from "@angular/material/checkbox";

@NgModule({
  declarations: [AuditAccessLogsComponent],
  exports: [AuditAccessLogsComponent],
  imports: [CommonModule, PaginationModule, FormsModule, MatTooltipModule, CustomTableModule, MatCheckboxModule]
})
export class AuditAccessLogsModule {}