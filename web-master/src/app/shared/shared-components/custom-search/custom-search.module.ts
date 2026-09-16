import { CommonModule } from "@angular/common";
import { CustomSearchComponent } from "./custom-search.component";
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms";

@NgModule({
  declarations: [CustomSearchComponent],
  exports: [CustomSearchComponent],
  imports: [CommonModule, FormsModule]
})
export class CustomSearchModule {}