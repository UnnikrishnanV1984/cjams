import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MedicalPractitionerRoutingModule } from './medical-practitioner-routing.module';
import { MedicalPractitionerComponent } from './medical-practitioner.component';
import {MatRadioModule} from '@angular/material/radio';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    MedicalPractitionerRoutingModule,
    MatRadioModule,
    FormsModule,
    ReactiveFormsModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    PaginationModule
  ],
  declarations: [MedicalPractitionerComponent]
})
export class MedicalPractitionerModule { }
