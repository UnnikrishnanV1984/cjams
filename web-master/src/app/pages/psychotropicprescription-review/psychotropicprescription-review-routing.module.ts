import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PsychotropicprescriptionReviewComponent } from './psychotropicprescription-review.component';


const routes: Routes = [
  {
    path: '',
    component: PsychotropicprescriptionReviewComponent,
  },
   { path: 'psychotropicprescription-report', 
  loadChildren: () => import( './psychotropicprescription-report/psychotropicprescription-report.module').then(m => m.PsychotropicprescriptionreportModule),pathMatch :'full' },
]; 

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PsychotropicPrescriptionReviewRoutingModule { }
