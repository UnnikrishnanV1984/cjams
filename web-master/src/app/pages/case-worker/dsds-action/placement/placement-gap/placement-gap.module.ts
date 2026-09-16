import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { AgePipe } from '../../../../../@core/pipes/age.pipe';
import { AgreementComponent } from './agreement/agreement.component';
import { AnnualReviewsComponent } from './annual-reviews/annual-reviews.component';
import { AssignmentsComponent } from './assignments/assignments.component';
import { DisclosureChecklistComponent } from './disclosure-checklist/disclosure-checklist.component';
import { PlacementGapRoutingModule } from './placement-gap-routing.module';
import { PlacementGapComponent } from './placement-gap.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { Title4eModule } from '../../../../title4e/title4e.module';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { GoogleMapsModule } from '@angular/google-maps';

import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ApplicationComponent } from './application/application.component';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { ServiceCasePlacementsService } from '../../service-case-placements/service-case-placements.service';
import { FiscalAuditModule } from '../../../../finance/fiscal-audit/fiscal-audit.module';
import { FinanceService } from '../../../../finance/finance.service';
import {PlacementGapResolverService} from './placement-gap-resolver-service';
import { RateComponent } from './rate/rate.component';
import { FinalizationChecklistComponent } from './finalization-checklist/finalization-checklist.component'
import { MatMenuModule } from '@angular/material/menu';
import { DocumentUploadListSharedModule } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
// import { SharedComponentsModule } from '../../../../../../../src/app/shared/shared-components/shared-components.module';


@NgModule({
    imports: [
        CommonModule,
        PlacementGapRoutingModule,
        FormMaterialModule,
         SharedDirectivesModule,
        SharedPipesModule,
        Title4eModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        PaginationModule,
        GoogleMapsModule,
        FiscalAuditModule,
        MatMenuModule,
        // SharedComponentsModule,
        NgxMaskDirective,NgxMaskPipe,
        DocumentUploadListSharedModule, AttachmentUploadsharedModule,SignatureFieldModule
    ],
    declarations: [AgePipe, PlacementGapComponent, AgreementComponent, AnnualReviewsComponent, AssignmentsComponent, DisclosureChecklistComponent, ApplicationComponent, RateComponent, FinalizationChecklistComponent],
    providers: [ServiceCasePlacementsService, FinanceService,PlacementGapResolverService,provideNgxMask()]
})
export class PlacementGapModule {}