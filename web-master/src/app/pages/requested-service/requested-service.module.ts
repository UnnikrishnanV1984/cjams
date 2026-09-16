import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatRadioModule } from '@angular/material/radio';
import { RequestedServiceRoutingModule } from './requested-service-routing.module';
import { RequestedServiceComponent } from './requested-service.component';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { IntakeUtils } from '../_utils/intake-utils.service';

@NgModule({
  imports: [
    CommonModule,
    RequestedServiceRoutingModule,
    MatRadioModule,
    MatFormFieldModule,
    FormsModule,
    ReactiveFormsModule,
    MatInputModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatRadioModule,
    MatTabsModule,
    MatTooltipModule,
    MatCheckboxModule,
    MatListModule,
    MatCardModule,
    MatTableModule,
    MatExpansionModule,
    MatChipsModule,
    MatIconModule,
    SortTableModule,
    PaginationModule,
    SharedDirectivesModule,
    SharedPipesModule
  ],
  declarations: [RequestedServiceComponent],
  providers: [IntakeUtils]
})
export class RequestedServiceModule { }
