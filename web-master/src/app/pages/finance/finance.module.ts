import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { FinanceRoutingModule } from './finance-routing.module';
import { FinanceComponent } from './finance.component';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { FinanceService } from './finance.service';
import { FinanceResolverService } from './finance-resolver-service';

@NgModule({
    imports: [
        CommonModule,
        FinanceRoutingModule,
        MatSortModule,
        SortTableModule
    ],
    declarations: [FinanceComponent],
    providers: [FinanceService, FinanceResolverService]
})

export class FinanceModule { }