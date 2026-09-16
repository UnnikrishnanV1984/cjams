import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MaintainServiceStructuresRoutingModule } from './maintain-service-structures-routing.module';
import { MaintainServiceStructuresComponent } from './maintain-service-structures.component';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


@NgModule({
  imports: [
    CommonModule,
    MaintainServiceStructuresRoutingModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatListModule,
    MatNativeDateModule,
    MatSelectModule,
    // A2Edatetimepicker,
    PaginationModule,
    MatRadioModule,
    NgSelectModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [MaintainServiceStructuresComponent]
})
export class MaintainServiceStructuresModule { }
