import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CasePlanComponent } from './case-plan.component';
import { CasePlanResolverService } from './case-plan-resolver.service';
import { CasePlanOneComponent } from './case-plan-one/case-plan-one.component';
import { CasePlanFourComponent } from './case-plan-four/case-plan-four.component';
import { CasePlanThreeComponent } from './case-plan-three/case-plan-three.component';
import { CasePlanTwoComponent } from './case-plan-two/case-plan-two.component';
import { CasePlanRBResolverService } from './caseplan-resolver-service';
import { CasePlanFiveComponent } from './case-plan-five/case-plan-five.component';
const routes: Routes = [
  {
  path: '',
  component: CasePlanComponent,
  resolve: {
    config: CasePlanResolverService,
    result: CasePlanRBResolverService
  },
  children: [
    {
      path: 'case-plan-one',
      component: CasePlanOneComponent
    },
    {
      path: 'case-plan-two',
      component: CasePlanTwoComponent
    },
    {
      path: 'case-plan-three',
      component: CasePlanThreeComponent
    },
    {
      path: 'case-plan-four',
      component: CasePlanFourComponent
    },
    {
      path: 'case-plan-five',
      component: CasePlanFiveComponent
    }


  ]
 }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CasePlanRoutingModule { }
