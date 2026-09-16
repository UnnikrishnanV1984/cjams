import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';

import { PlacementAdoptionRoutingModule } from './placement-adoption-routing.module';
import { PlacementAdoptionComponent } from './placement-adoption.component';
import { AdoptionTprRecomendationComponent } from './adoption-tpr-recomendation/adoption-tpr-recomendation.component';
import { AdoptionLegalCustodyComponent } from './adoption-legal-custody/adoption-legal-custody.component';
import { AdoptionTprComponent } from './adoption-tpr/adoption-tpr.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { AdoptionModule } from '../../../../title4e/adoption/titleIVe-adoption.module';
import { PlacementAdoptionResolverService } from './placement-adoption-resolver.service';
import { PlacementAdoptionService } from './placement-adoption.service';
import { FormMaterialModule } from '../../../../../@core/form-material.module';
import { ServiceCasePermanencyPlanService } from '../../service-case-permanency-plan/service-case-permanency-plan.service';
import { SharedDirectivesModule } from '../../../../../@core/directives/shared-directives.module';
import { DocumentUploadListSharedModule } from '../../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';

@NgModule({
  imports: [
    CommonModule,
    PlacementAdoptionRoutingModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    ReactiveFormsModule,
    SharedPipesModule,
    ReactiveFormsModule,
    AdoptionModule,
    SharedDirectivesModule,
    DocumentUploadListSharedModule, AttachmentUploadsharedModule
  ],
  declarations: [PlacementAdoptionComponent, AdoptionTprRecomendationComponent, AdoptionLegalCustodyComponent, AdoptionTprComponent],
  providers: [PlacementAdoptionResolverService, PlacementAdoptionService, ServiceCasePermanencyPlanService]
})
export class PlacementAdoptionModule { }
