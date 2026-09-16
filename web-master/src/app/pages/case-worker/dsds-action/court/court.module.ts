import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CourtRoutingModule } from './court-routing.module';
import { CourtTabComponent } from './court-tab/court-tab.component';
import { NotesComponent } from './notes/notes.component';
import { CourtComponent } from './court.component';
import { HearingDetailComponent } from './hearing-detail/hearing-detail.component';
import { PetitionDetailComponent } from './petition-detail/petition-detail.component';
import { CourtActionsComponent } from './court-actions/court-actions.component';
import { CourtDetailComponent } from './court-detail/court-detail.component';
import { CourtOrderComponent } from './court-order/court-order.component';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { AsCourtProcessingComponent } from './as-court-processing/as-court-processing.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { QuillModule } from 'ngx-quill';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { LegalCustodyComponent } from './legal-custody/legal-custody.component';
import { InvolvedPersonsService } from '../../../shared-pages/involved-persons/involved-persons.service';
import { CommonControlsModule } from '../../../../shared/modules/common-controls/common-controls.module';
import { MatTooltipModule } from '@angular/material/tooltip';
import {CourtResolverService} from './court-resolver-service'
import { CourtTprComponent } from './court-tpr/court-tpr.component';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatRadioModule } from '@angular/material/radio';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { MatTimepickerModule } from '@angular/material/timepicker';
import { ShareFeaturesModule } from '../../../../pages/shared-pages/person-info/share-features/share-features.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { NewYouthTransitionPlanModule } from '../service-plan/youth-transition-plan-new/youth-transition-plan.module';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};

@NgModule({
    imports: [
        CommonModule,
        CourtRoutingModule,
        SharedDirectivesModule,
        FormMaterialModule,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        NgxMaskDirective,
        NgxMaskPipe,
        // A2Edatetimepicker,
        QuillModule.forRoot(),
        ControlMessagesModule,
        MatTooltipModule,
        CommonControlsModule,
        // SharedComponentsModule,
        PaginationModule,
        SharedPipesModule,
        ShareFeaturesModule,
        MatDatepickerModule,
        NewYouthTransitionPlanModule,
        MatRadioModule,
        MatMomentDatetimeModule, MatDatetimepickerModule,
        MatTimepickerModule,
        ShareFeaturesModule,
        OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule, GlobalPopupModule,
        DocumentUploadListSharedModule, AttachmentUploadsharedModule
    ],
    declarations: [
        CourtComponent,
        NotesComponent,
        CourtTabComponent,
        HearingDetailComponent,
        PetitionDetailComponent,
        CourtActionsComponent,
        CourtDetailComponent,
        CourtOrderComponent,
        AsCourtProcessingComponent,
        LegalCustodyComponent,
        CourtTprComponent
    ],
    providers: [InvolvedPersonsService, CourtResolverService,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
})
export class CourtModule {}
