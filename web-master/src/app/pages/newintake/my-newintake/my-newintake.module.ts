import 'trumbowyg/dist/trumbowyg.min.js';
import { CommonModule } from '@angular/common';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
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
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PdfViewerModule } from 'ng2-pdf-viewer';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { TimepickerModule } from 'ngx-bootstrap/timepicker';
import { ImageCropperComponent } from 'ngx-image-cropper';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { QuillModule } from 'ngx-quill';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';
// import { NgxTrumbowygModule } from "ngx-trumbowyg";
// import { TrumbowygNgxModule } from 'trumbowyg-ngx';

import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { SpeechRecognitionService } from '../../../@core/services/speech-recognition.service';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
import { SpeechRecognizerService } from '../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { MyNewintakeRoutingModule } from './my-newintake-routing.module';
import { IntakeDocumentCreatorModule } from './intake-document-creator/intake-document-creator.module';
import { NoticePreintakeLetterComponent } from './intake-document-creator/notice-preintake-letter/notice-preintake-letter.component';
import { AcknowledgementLetterComponent } from './intake-document-creator/acknowledgement-letter/acknowledgement-letter.component';
import { MyNewintakeResolverService } from './my-newintake-resolver.service';
import { CommunicationResolverService } from './communication-resolver.service';
import { PurposeResolverService } from './purpose-resolver.service';
import { IntakeConfigService } from './intake-config.service';
import { PersonResolverService } from './person-resolver.service';
import { InvolvedPersonsModule } from '../../shared-pages/involved-persons/involved-persons.module';
import { RelationshipModule } from '../../case-worker/dsds-action/relationship/relationship.module';
import { RelationshipNewModule } from '../../shared-pages/relationship-new/relationship-new.module';
import { RecordingModule } from '../../case-worker/dsds-action/recording/recording.module';
import { DsdsService } from '../../case-worker/dsds-action/_services/dsds.service';
import { IntakeSdmModule } from './intake-sdm/intake-sdm.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { MyNewintakeComponent } from './my-newintake.component';
import { IntakeDispositionComponent } from './intake-disposition/intake-disposition.component';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';
import { OwlDateTimeModule, OwlNativeDateTimeModule, OWL_DATE_TIME_FORMATS } from '@danielmoncada/angular-datetime-picker';
import { OwlMomentDateTimeModule } from '@danielmoncada/angular-datetime-picker-moment-adapter';

export const MY_MOMENT_FORMATS = {
  parseInput: 'MM/DD/YYYY h:mm A',
  fullPickerInput: 'MM/DD/YYYY h:mm A',
  datePickerInput: 'MM/DD/YYYY h:mm A',
  timePickerInput: 'h:mm A',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'LL',
  monthYearA11yLabel: 'MMMM YYYY',
};

// tslint:disable-next-line:max-line-length
@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        SharedDirectivesModule,
        MatDatepickerModule,
        MatNativeDateModule,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatButtonModule,
        MatRadioModule,
        MatTabsModule,
        MatTooltipModule,
        MatCheckboxModule,
        MatListModule,
        MatCardModule,
        MatTableModule,
        MatExpansionModule,
        MatChipsModule,
        MatIconModule,
         MyNewintakeRoutingModule,
         PaginationModule,
        TimepickerModule,
        ControlMessagesModule,
        SharedDirectivesModule,
        SharedPipesModule,
        NgSelectModule,
        ImageCropperComponent,
        SortTableModule,
        RelationshipModule,
        RelationshipNewModule,
        RecordingModule,
        MatAutocompleteModule,
        // NgxTrumbowygModule.withConfig({
        //     svgPath: "../../../../assets/images/icons.svg",
        // }),
        // A2Edatetimepicker,
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        QuillModule.forRoot(),
        PdfViewerModule,
        IntakeDocumentCreatorModule,
        InvolvedPersonsModule,
        IntakeSdmModule,
        PopoverModule,
        NgxMaskDirective,
        NgxMaskPipe,
        MatMomentDatetimeModule, MatDatetimepickerModule,
        OwlDateTimeModule, OwlNativeDateTimeModule, OwlMomentDateTimeModule 
    ],
    declarations: [
        MyNewintakeComponent,
         NoticePreintakeLetterComponent,
        AcknowledgementLetterComponent,
        IntakeDispositionComponent
    ],
    exports: [MyNewintakeComponent],
    schemas: [CUSTOM_ELEMENTS_SCHEMA],
    providers: [SpeechRecognitionService, SpeechRecognizerService, NgxfUploaderService, MyNewintakeResolverService, IntakeConfigService, CommunicationResolverService, PurposeResolverService, PersonResolverService,DsdsService,provideNgxMask(), { provide: OWL_DATE_TIME_FORMATS, useValue: MY_MOMENT_FORMATS }]
    })
export class MyNewintakeModule { }
