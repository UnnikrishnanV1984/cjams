import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ServiceCaseManagementModule } from '../../../../shared-pages/service-case-management/service-case-management.module';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatButtonModule } from '@angular/material/button';
import { MatAutocompleteModule } from '@angular/material/autocomplete';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NgSelectModule } from '@ng-select/ng-select';

import { CommonHttpService } from '../../../../../@core/services';
import { GoogleMapsModule } from '@angular/google-maps';

import { PlanOfSafeCareComponent } from './plan-of-safecare.component';
import {  PlanofSafecareSectionOneComponent } from './plan-of-safecare-section-one/plan-of-safecare-section-one.component';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SortTableModule } from '../../../../../shared/modules/sortable-table/sortable-table.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { ServiceCasePermanencyPlanService } from '../../service-case-permanency-plan/service-case-permanency-plan.service';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import { PlanOfSafeCareTwoComponent } from './plan-of-safecare-section-two/plan-of-safecare-section-two.component';
import { PlanOfSafeCareRoutingModule } from './plan-of-safecare-routing.module';
import { PlanOfSafeCareThreeComponent } from './plan-of-safecare-section-three/Plan-of-safecare-section-three.component';
import { PlanOfSafeCareFourComponent } from './plan-of-safecare-section-four/Plan-of-safecare-section-four.component';
import { PlanOfSafeCareFiveComponent } from './Plan-of-safecare-section-five/Plan-of-safecare-section-five.component';
import { PlanOfSafeCareSixComponent } from './Plan-of-safecare-section-six/Plan-of-safecare-section-six.component';
import { PlanOfSafeCareSevenComponent } from './Plan-of-safecare-section-seven/Plan-of-safecare-section-seven.component';
import { PlanOfSafeCareEightComponent } from './Plan-of-safecare-section-eight/Plan-of-safecare-section-eight.component';
import { CommonControlsModule } from '../../../../../shared/modules/common-controls/common-controls.module';
import { MatTooltipModule } from '@angular/material/tooltip';
import { CustomTableModule } from '../../../../../shared/shared-components/custom-table/custom-table.module';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
// import { SharedComponentsModule } from '../../../../../shared/shared-components/shared-components.module';

@NgModule({
    imports: [
        CommonModule,
        MatTabsModule,
        MatSelectModule,
        //FormMaterialModule,
        MatTableModule,
        MatDatepickerModule,
        MatFormFieldModule,
        MatInputModule,
        MatCheckboxModule,
        MatAutocompleteModule,
        ReactiveFormsModule,
        FormsModule,
        PaginationModule,
        // A2Edatetimepicker,
        NgSelectModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        MatNativeDateModule,
        MatButtonModule,
        MatRadioModule,
        MatListModule,
        MatCardModule,
        MatExpansionModule,
        // AgmCoreModule
        GoogleMapsModule,
        SharedDirectivesModule,
        SortTableModule,
        ServiceCaseManagementModule,
        PlanOfSafeCareRoutingModule,
        CommonControlsModule,
        MatTooltipModule,
        NgxMaskDirective,
        NgxMaskPipe,
        // SharedComponentsModule,
        CustomTableModule,
        SignatureFieldModule
    ],
    declarations: [
        PlanOfSafeCareComponent,
       PlanofSafecareSectionOneComponent ,
       PlanOfSafeCareTwoComponent,
       PlanOfSafeCareThreeComponent,
       PlanOfSafeCareFourComponent,
       PlanOfSafeCareFiveComponent,
       PlanOfSafeCareSixComponent,
       PlanOfSafeCareSevenComponent,
       PlanOfSafeCareEightComponent
    ],
    
    providers: [CommonHttpService, ServiceCasePermanencyPlanService, ChildRemovalService,provideNgxMask()]
})
export class PlanOfSafeCareModule {}
