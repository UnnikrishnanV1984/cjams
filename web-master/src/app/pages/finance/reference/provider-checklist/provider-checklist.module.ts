import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProviderChecklistRoutingModule } from './provider-checklist-routing.module';
import { ProviderChecklistComponent } from './provider-checklist.component';
import { ProviderChecklistSearchComponent } from './provider-checklist-search/provider-checklist-search.component';
import { ProviderChecklistResultComponent } from './provider-checklist-result/provider-checklist-result.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';

@NgModule({
  imports: [
    CommonModule,
    ProviderChecklistRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule, 
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    MatRippleModule,
    MatButtonModule,
    MatRadioModule
  ],
  declarations: [ProviderChecklistComponent, ProviderChecklistSearchComponent, ProviderChecklistResultComponent]
})
export class ProviderChecklistModule { }
