import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CasePlanComponent } from './case-plan.component';
import { CasePlanResolverService } from './case-plan-resolver.service';
import { CasePlanRoutingModule } from './case-plan-routing.module';
import { CasePlanService } from './case-plan.service';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { CasePlanOneComponent } from './case-plan-one/case-plan-one.component';
import { CasePlanFourComponent } from './case-plan-four/case-plan-four.component';
import { CasePlanTwoComponent } from './case-plan-two/case-plan-two.component';
import { CasePlanThreeComponent } from './case-plan-three/case-plan-three.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { CasePlanLegacyComponent } from './case-plan-legacy/case-plan-legacy.component';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { CasePlanRBResolverService } from './caseplan-resolver-service';
import { CasePlanFiveComponent } from './case-plan-five/case-plan-five.component';
@NgModule({
  imports: [
    CommonModule,
    CasePlanRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    PopoverModule,
    SharedPipesModule
  ],
  declarations: [
    CasePlanComponent,
    CasePlanOneComponent,
    CasePlanTwoComponent,
    CasePlanThreeComponent,
    CasePlanFourComponent,
    CasePlanFiveComponent,
    CasePlanLegacyComponent
  ],
  providers: [
    CasePlanResolverService, 
    CasePlanService,
    CasePlanRBResolverService
  ]
})
export class CasePlanModule { }
