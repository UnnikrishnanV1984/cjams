import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AssessmentComponent } from './assessment.component';
import { AssessmentResolverService } from './assessment-resolver-service';
const routes: Routes = [
    {
    path: '',
    component: AssessmentComponent,
    // resolve: {
    //   result: AssessmentResolverService
    //   }
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AssessmentRoutingModule { }
