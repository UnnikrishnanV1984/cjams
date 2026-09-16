import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlanOfSafeCareTwoComponent } from './plan-of-safecare-section-two/plan-of-safecare-section-two.component';
import { PlanofSafecareSectionOneComponent } from './plan-of-safecare-section-one/plan-of-safecare-section-one.component';
import { PlanOfSafeCareComponent } from './plan-of-safecare.component';
import { PlanOfSafeCareEightComponent } from './Plan-of-safecare-section-eight/Plan-of-safecare-section-eight.component';
import { PlanOfSafeCareSevenComponent } from './Plan-of-safecare-section-seven/Plan-of-safecare-section-seven.component';
import { PlanOfSafeCareSixComponent } from './Plan-of-safecare-section-six/Plan-of-safecare-section-six.component';
import { PlanOfSafeCareFiveComponent } from './Plan-of-safecare-section-five/Plan-of-safecare-section-five.component';
import { PlanOfSafeCareFourComponent } from './plan-of-safecare-section-four/Plan-of-safecare-section-four.component';
import { PlanOfSafeCareThreeComponent } from './plan-of-safecare-section-three/Plan-of-safecare-section-three.component';


const routes: Routes = [
   {
       path: '',
       component: PlanOfSafeCareComponent,
       children: [
         {path :  'section-one', component : PlanofSafecareSectionOneComponent},
         {path :  'section-two', component : PlanOfSafeCareTwoComponent},
         {path :  'section-three', component : PlanOfSafeCareThreeComponent},
         {path :  'section-four', component : PlanOfSafeCareFourComponent},
         {path :  'section-five', component : PlanOfSafeCareFiveComponent},
         {path :  'section-six', component : PlanOfSafeCareSixComponent},
         {path :  'section-seven', component : PlanOfSafeCareSevenComponent},
         {path :  'section-eight', component : PlanOfSafeCareEightComponent},
     ],
   }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
  })
  export class PlanOfSafeCareRoutingModule { }

