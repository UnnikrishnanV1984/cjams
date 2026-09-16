import { GoogleMapsModule } from '@angular/google-maps';

import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ApplaListComponent } from './appla-list/appla-list.component';
import { ApplaProcessRoutingModule } from './appla-process-routing.module';
import { ApplaProcessComponent } from './appla-process.component';
import { ApplaProcessService } from './appla-process.service';
import { ApplaViewComponent } from './appla-view/appla-view.component';


@NgModule({
  imports: [
    CommonModule,
    ApplaProcessRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatExpansionModule,
    // A2Edatetimepicker,
    GoogleMapsModule,
    PaginationModule
  ],
  declarations: [ApplaProcessComponent, ApplaViewComponent, ApplaListComponent],
  providers: [ApplaProcessService]
})
export class ApplaProcessModule { }
