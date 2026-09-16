import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonProfileRoutingModule } from './work-profile-routing.module';
import { WorkProfileComponent } from './work-profile.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { HttpClientModule } from '@angular/common/http';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';

@NgModule({
  imports: [
    CommonModule,
    PersonProfileRoutingModule,
    FormMaterialModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    HttpClientModule
  ],
  declarations: [WorkProfileComponent]
})
export class WorkProfileModule { }
