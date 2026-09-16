import { CommonModule } from "@angular/common";
import { CustomTableComponent } from "./custom-table.component";
import { NgModule } from "@angular/core";
import { PaginationModule } from "ngx-bootstrap/pagination";
import { FormsModule } from "@angular/forms";
import { MatTooltipModule } from "@angular/material/tooltip";
import { CustomInfoTooltipModule } from "../custom-info-tooltip/custom-info-tooltip.module";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { CustomSearchModule } from "../custom-search/custom-search.module";
import { SortTableModule } from "../../modules/sortable-table/sortable-table.module";
import { MatMenuModule } from "@angular/material/menu";
import { MatButtonModule } from "@angular/material/button";
import { MatIconModule } from "@angular/material/icon";
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  declarations: [CustomTableComponent],
  exports: [CustomTableComponent],
  imports: [CommonModule, PaginationModule, FormsModule, MatTooltipModule, CustomInfoTooltipModule, MatCheckboxModule, CustomSearchModule, SortTableModule, MatMenuModule, MatButtonModule, MatIconModule, SharedPipesModule]
})
export class CustomTableModule {}