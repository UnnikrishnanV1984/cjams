import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PsychotropicprescriptionreportComponent } from './psychotropicprescription-report.component';

const routes: Routes =[
    {
        path: '',
        component :PsychotropicprescriptionreportComponent
    }
];
@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
  })
  export class PsychotropicPrescriptionReportRoutingModule { }