import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PersonYouthstatusComponent } from './person-youthstatus.component';
import { PersonYouthstatusRoutingModule } from './person-youthstatus-routing.module';
import { QuillModule } from 'ngx-quill';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    MatSelectModule,
    PaginationModule,
    PersonYouthstatusRoutingModule,
    QuillModule.forRoot(),
  ],
  declarations: [PersonYouthstatusComponent]
})
export class PersonYouthstatusModule { }
