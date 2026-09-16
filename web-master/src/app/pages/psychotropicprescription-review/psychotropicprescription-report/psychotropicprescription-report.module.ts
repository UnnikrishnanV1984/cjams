import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PsychotropicprescriptionreportComponent } from './psychotropicprescription-report.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { PsychotropicPrescriptionReportRoutingModule } from './psychotropicprescription-report-routing.module';
// import { SharedComponentsModule } from '../../../shared/shared-components/shared-components.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CustomTableModule } from '../../../shared/shared-components/custom-table/custom-table.module';
import { MatMenuModule } from '@angular/material/menu';
// import { PopoverModule } from 'ngx-smart-popover';

@NgModule({
  declarations: [PsychotropicprescriptionreportComponent],
  imports: [
    PsychotropicPrescriptionReportRoutingModule ,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    FormMaterialModule,
    // SharedComponentsModule,
    PopoverModule.forRoot(),
    MatFormFieldModule,
    MatInputModule,
    CustomTableModule,
    MatMenuModule
  ]
  
})
export class PsychotropicprescriptionreportModule { }
