import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonRestitutionRoutingModule } from './person-restitution-routing.module';
import { PersonRestitutionComponent } from './person-restitution.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    PersonRestitutionRoutingModule,
    PaginationModule,
    FormsModule
  ],
  declarations: [PersonRestitutionComponent]
})
export class PersonRestitutionModule { }
