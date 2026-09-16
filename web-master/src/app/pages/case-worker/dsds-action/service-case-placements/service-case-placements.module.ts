import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ServiceCasePlacementsRoutingModule } from './service-case-placements-routing.module';
import { ServiceCasePlacementsComponent } from './service-case-placements.component';
import { ServiceCasePlacementsResolverService } from './service-case-placements-resolver.service';
import { ServiceCasePlacementsService } from './service-case-placements.service';
import { RemovedChildListComponent } from './removed-child-list/removed-child-list.component';
import { SelectedChildListComponent } from './selected-child-list/selected-child-list.component';
import { PlacmentWrapperComponent } from './placment-wrapper/placment-wrapper.component';
import { LivingArrangementFormComponent } from './placment-wrapper/living-arrangement-form/living-arrangement-form.component';
import { PlacementReferralComponent } from './placment-wrapper/placement-referral/placement-referral.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { PlacementListComponent } from './placement-list/placement-list.component';
import { PlacementDetailsComponent } from './placement-details/placement-details.component';
import { LivingArrangmentDetailsComponent } from './placement-details/living-arrangment-details/living-arrangment-details.component';
import { ProviderPlacmentDetailsComponent } from './placement-details/provider-placment-details/provider-placment-details.component';
import { provideNgxMask,NgxMaskDirective} from 'ngx-mask';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PlacementAddressInfoComponent } from './placement-address-info/placement-address-info.component';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ExitPlacementsComponent } from './exit-placements/exit-placements.component';
import { ExitPlacementService } from './exit-placements/exit-placement.service';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';

import { GoogleMapsModule } from '@angular/google-maps';

import { VoidPlacementFormComponent } from './void-placement-form/void-placement-form.component';
import { FiscalAuditModule } from '../../../finance/fiscal-audit/fiscal-audit.module';
import { FinanceService } from '../../../finance/finance.service';
import { LivingArrangmentEditComponent } from './placement-details/living-arrangement-edit/living-arrangment-edit.component';
import { InvolvedPersonsService } from '../../../shared-pages/involved-persons/involved-persons.service';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { PersonInfoModule } from '../../../shared-pages/person-info/person-info.module';
import { HospitalizationCwSharedModule } from '../../../../shared/shared-components/hospitalization-cw-shared/hospitalization-cw-shared.module';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';

@NgModule({
  imports: [
    CommonModule,
    ServiceCasePlacementsRoutingModule,
    FormMaterialModule,
    MatMenuModule,
    MatTooltipModule,
    PaginationModule,
    MatListModule,
    SharedPipesModule,
    FiscalAuditModule,
    // SharedComponentsModule,
    PersonInfoModule,
    PopoverModule,
    GoogleMapsModule,
    NgxMaskDirective,
    HospitalizationCwSharedModule,
    GlobalPopupModule
  ],
  declarations: [ServiceCasePlacementsComponent,
    RemovedChildListComponent,
    SelectedChildListComponent,
    PlacmentWrapperComponent,
    LivingArrangementFormComponent,
    PlacementReferralComponent,
    PlacementListComponent,
    PlacementDetailsComponent,
    LivingArrangmentDetailsComponent,
    LivingArrangmentEditComponent,
    ProviderPlacmentDetailsComponent,
    PlacementAddressInfoComponent,
    ExitPlacementsComponent,
    VoidPlacementFormComponent],
  providers: [ServiceCasePlacementsResolverService,
    ServiceCasePlacementsService,
    ExitPlacementService,
    FinanceService,InvolvedPersonsService,
  provideNgxMask()]
})
export class ServiceCasePlacementsModule { }
