import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PhysicalAttributesRoutingModule } from './physical-attributes-routing.module';
import { PhysicalAttributesComponent } from './physical-attributes.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    PhysicalAttributesRoutingModule,
    PaginationModule,
    FormsModule
  ],
  declarations: [PhysicalAttributesComponent]
})
export class PhysicalAttributesModule { }
