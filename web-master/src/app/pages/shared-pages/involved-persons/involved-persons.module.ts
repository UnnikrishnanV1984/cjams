import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { InvolvedPersonsRoutingModule } from './involved-persons-routing.module';
import { InvolvedPersonsComponent } from './involved-persons.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { InvolvedPersonsService } from './involved-persons.service';
import { InvolvedPersonsResolverService } from './involved-persons-resolver.service';
import { PersonsGridCwComponent } from './persons-grid-cw/persons-grid-cw.component';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { FindIndividualService } from './find-individual/find-individual.service';
import { CollateralNewModule } from '../collateral-new/collateral-new.module';
import { QuickPersonHistoryModule } from '../quick-person-history/quick-person-history.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { TransferHistoryApprovedService } from '../../../shared/services/transfer-history-approved.service';
import { AddressDetailsService } from '../person-info/address-details/address-details.service';
import { PopoverModule,PopoverConfig } from 'ngx-bootstrap/popover';
import { MatDialogModule } from '@angular/material/dialog';
import { GlobalPopupModule } from '../../../shared/shared-components/global-popup/global-popup.module';
// import { SharedComponentsModule } from '../../../shared/shared-components/shared-components.module';

@NgModule({
  imports: [
    CommonModule,
    InvolvedPersonsRoutingModule,
    FormMaterialModule,
    CollateralNewModule,
    QuickPersonHistoryModule,
    SharedPipesModule,
    PopoverModule.forRoot(),
    MatDialogModule,
    // SharedComponentsModule,
    GlobalPopupModule
  ],
  declarations: [InvolvedPersonsComponent, PersonsGridCwComponent],
  providers: [InvolvedPersonsService,
    InvolvedPersonsResolverService,
    FindIndividualService,
    TransferHistoryApprovedService,
    NavigationUtils,
    IntakeUtils,
    AddressDetailsService]
})
export class InvolvedPersonsModule { }
