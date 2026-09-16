import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InvestigationFindingsComponent } from './investigation-findings.component';
import { InvestigationFindingsResolverService } from './investigation-findings-resolver';

const routes: Routes = [{
  path: '', component: InvestigationFindingsComponent,
  // resolve: {
  //   result: InvestigationFindingsResolverService
  // }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InvestigationFindingsRoutingModule { }
