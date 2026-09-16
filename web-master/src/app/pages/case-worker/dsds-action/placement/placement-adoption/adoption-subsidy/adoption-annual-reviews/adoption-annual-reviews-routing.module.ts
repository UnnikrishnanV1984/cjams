import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdoptionAnnualReviewsComponent } from './adoption-annual-reviews.component';

const routes: Routes = [{
  path: '',
  component: AdoptionAnnualReviewsComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdoptionAnnualReviewsRoutingModule { }
