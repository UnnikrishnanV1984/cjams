import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { DaStatusDispositionModule } from './da-status-disposition/da-status-disposition.module';
import { DistributionListModule } from './distribution-list/distribution-list.module';
import { GeneralRoutingModule } from './general-routing.module';
import { GeneralComponent } from './general.component';
import { ManageDsdsActionTypeModule } from './manage-dsds-action-type/manage-dsds-action-type.module';

@NgModule({
    imports: [CommonModule, GeneralRoutingModule,
        ManageDsdsActionTypeModule,
        DaStatusDispositionModule, DistributionListModule],
    declarations: [GeneralComponent],
    exports: [GeneralComponent],
    providers: []
})
export class GeneralModule {}
