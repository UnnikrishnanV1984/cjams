import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { NewSaveintakeComponent } from './new-saveintake/new-saveintake.component';
import { NewintakeRoutingModule } from './newintake-routing.module';
import { NewintakeComponent } from './newintake.component';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatChipsModule } from '@angular/material/chips';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatTooltipModule } from '@angular/material/tooltip';

import { IntakeConfigService } from './my-newintake/intake-config.service';
import { PurposeResolverService } from './my-newintake/purpose-resolver.service';
import { TransferHistoryApprovedService } from '../../shared/services/transfer-history-approved.service';

@NgModule({
    imports: [MatTooltipModule, MatFormFieldModule, CommonModule, NewintakeRoutingModule, FormsModule, ReactiveFormsModule, PaginationModule, SharedDirectivesModule,
         SharedPipesModule, MatAutocompleteModule, MatChipsModule, SortTableModule],
    declarations: [NewintakeComponent, NewSaveintakeComponent],
    providers: [IntakeConfigService, PurposeResolverService, 
        TransferHistoryApprovedService
    ]
})
export class NewintakeModule {}
