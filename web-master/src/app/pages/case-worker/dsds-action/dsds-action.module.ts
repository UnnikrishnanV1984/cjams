import { GoogleMapsModule } from '@angular/google-maps';

import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { QuillModule } from 'ngx-quill';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { MatRadioModule } from '@angular/material/radio';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SpeechSynthesizerService } from '../../../shared/modules/web-speech/shared/services/speech-synthesizer.service';
import { CaseWorkerDocumentCreatorComponent } from './case-worker-document-creator/case-worker-document-creator.component';

import { DsdsActionRoutingModule } from './dsds-action-routing.module';
import { DsdsActionComponent } from './dsds-action.component';
import { SpeechRecognitionService } from '../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { DsdsService } from './_services/dsds.service';
import { CommonControlsModule } from '../../../shared/modules/common-controls/common-controls.module';
import { FolderChangeComponent } from './folder-change/folder-change.component';
import { IntakeConfigService } from '../../newintake/my-newintake/intake-config.service';
import { RelationshipNewModule } from '../../shared-pages/relationship-new/relationship-new.module';
// import { SharedComponentsModule } from '../../../shared/shared-components/shared-components.module';
import { NarrativeModule } from './narrative/narrative.module';
import { AdoptionPersonsModule } from './adoption-persons/adoption-persons.module';
import { AssessmentService } from './assessment/assessment.service';
import { ExcelService } from '../../home-dashboard/excel.service';
import { DsdsActionResolverService } from './dsds-action-resolver.service';
import { CpsDocLetterModule } from '../../newintake/my-newintake/intake-document-creator/cps-doc-letter/cps-doc-letter.module';
import { GlobalPopupModule } from '../../../shared/shared-components/global-popup/global-popup.module';
// tslint:disable-next-line:max-line-length
@NgModule({
    imports: [
        CommonModule,
        DsdsActionRoutingModule,
        SharedDirectivesModule,
        ReactiveFormsModule,
        FormsModule,
        MatCardModule,
        MatCheckboxModule,
        MatDatepickerModule,
        MatExpansionModule,
        MatFormFieldModule,
        RelationshipNewModule,
        MatInputModule,
        MatListModule,
        MatNativeDateModule,
        MatRadioModule,
        MatSelectModule,
        MatTableModule,
        MatTabsModule,
        PaginationModule,
        BsDatepickerModule,
        ControlMessagesModule,
        NgSelectModule,
        SharedDirectivesModule,
        SharedPipesModule,
        // A2Edatetimepicker,
         NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        QuillModule.forRoot(),
        GoogleMapsModule,
        CommonControlsModule,
        // SharedComponentsModule,
        NarrativeModule,
        AdoptionPersonsModule,
        NgxMaskDirective,
        NgxMaskPipe,
        CpsDocLetterModule,
        GlobalPopupModule
    ],
    exports: [
        DsdsActionComponent
      
        ],
    // tslint:disable-next-line:max-line-length
    declarations: [
        DsdsActionComponent,
         CaseWorkerDocumentCreatorComponent,
         FolderChangeComponent,

    ],
    providers: [
        SpeechSynthesizerService,
        SpeechRecognitionService,
        SpeechRecognizerService,
        DsdsService,
        IntakeConfigService,
        AssessmentService,
        ExcelService,
        DsdsActionResolverService,
       provideNgxMask(),
    ]
})
export class DsdsActionModule { }
