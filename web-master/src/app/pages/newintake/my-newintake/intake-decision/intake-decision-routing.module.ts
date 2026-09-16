import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeDecisionComponent } from './intake-decision.component';
import { IntakeDecisionResolverService } from './intake-decision-resolver.service';

const routes: Routes = [{
  path: '',
  component: IntakeDecisionComponent,
  resolve: {
    items: IntakeDecisionResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeDecisionRoutingModule { }
