import { CommonModule } from "@angular/common";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatCheckboxModule } from "@angular/material/checkbox";
import { MatInputModule } from "@angular/material/input";
import { MatSelectModule } from "@angular/material/select";
import { MatTableModule } from "@angular/material/table";
import { MatTabsModule } from "@angular/material/tabs";
import { NgSelectModule } from "@ng-select/ng-select";
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgxPaginationModule } from "ngx-pagination";
import { SortTableModule } from '../../../app/shared/modules/sortable-table/sortable-table.module';
import { PContactlogReleasenotesRoutingModule } from "./contactlog-releasenotes-routing.module";
import { ContactlogReleasenotesComponent } from "./contactlog-releasenotes.component";
import { ViewTicketsComponent } from "./view-tickets/view-tickets.component";
import { HighchartsChartModule } from 'highcharts-angular';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { CommonControlsModule } from '../../../app/shared/modules/common-controls/common-controls.module';
import { MatTooltipModule } from "@angular/material/tooltip";


@NgModule({
    imports: [
        NgSelectModule,
        MatInputModule,
        MatSelectModule,
        MatTableModule,
        MatTableModule,
        MatTabsModule,
        CommonModule,
        FormsModule,
        MatCheckboxModule,
        PContactlogReleasenotesRoutingModule,
        PaginationModule.forRoot(),
        NgxPaginationModule,
        ReactiveFormsModule,
        SortTableModule,
        MatCheckboxModule,
        HighchartsChartModule,
        MatExpansionModule,
        MatFormFieldModule,
        MatAutocompleteModule,
        CommonControlsModule,
        MatTooltipModule
    ],
    declarations: [ViewTicketsComponent,ContactlogReleasenotesComponent],
    providers: []
  })
  export class ContactlogReleasenotesModule { }