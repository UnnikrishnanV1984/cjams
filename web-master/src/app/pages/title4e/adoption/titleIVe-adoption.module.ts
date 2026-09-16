import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { QuillModule } from 'ngx-quill';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { AdoptionRoutingModule } from './titleIVe-adoption-routing.module';
import { AdoptionComponent } from './titleIVe-adoption.component';
import { AdoptionResolverService } from './titleIVe-adoption-resolver.service';
import { AdoptionChildAssessmentComponent } from './adoption-child-assessment/adoption-child-assessment.component';
import { AdoptionApplicabilityDecisionComponent } from './adoption-applicability-decision/adoption-applicability-decision.component';
import { AdoptionSignatureFeildComponent } from './adoption-applicability-decision/adoption-signature-feild/adoption-signature-feild.component';
import { AdoptionEligibilityComponent } from './adoption-eligibility/adoption-eligibility.component';
import { AdoptionExtendedComponent } from './adoption-extended/adoption-extended.component';
import { AdoptionNarrativeComponent } from './adoption-narrative/adoption-narrative.component';
import { AdoptionReportsComponent } from './adoption-reports/adoption-reports.component';
import { AdoptionEligibilityDetailsComponent } from './adoption-eligibility-details/adoption-eligibility-details.component';
import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgxPrintModule } from 'ngx-print';
import { MatChipsModule } from '@angular/material/chips';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { AttachmentComponent } from './attachment/attachment.component';
import {ControlMessagesModule} from '../../../shared/modules/control-messages/control-messages.module';
import { MatMenuModule } from '@angular/material/menu';
import { DocumentUploadListSharedModule } from '../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';
import { SignatureFieldModule } from '../../../shared/modules/common-controls/signature-field/signature-field.module';
import { EditAttachmentSharedModule } from '../../../shared/shared-components/edit-attachment-shared/edit-attachment-shared.module';
// import { SharedComponentsModule } from '../../../../../src/app/shared/shared-components/shared-components.module';
@NgModule({
    imports: [NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        MatDatepickerModule,
        MatTooltipModule,
        MatChipsModule,
        MatButtonModule,
        MatIconModule,
        MatNativeDateModule,
        NgSelectModule,
        // A2Edatetimepicker,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatRadioModule,
        MatTabsModule,
        MatCheckboxModule,
        MatListModule,
        MatCardModule,
        MatButtonToggleModule,
        FormMaterialModule,
        MatTableModule,
        MatExpansionModule,
        MatStepperModule,
        MatPaginatorModule,
          MatDialogModule,  MatFormFieldModule, CommonModule,QuillModule.forRoot(),  FormsModule, ReactiveFormsModule, PaginationModule,
          MatAutocompleteModule, AdoptionRoutingModule, AngularSignaturePadModule, NgxPrintModule, ControlMessagesModule,MatMenuModule,
        //   SharedComponentsModule
        DocumentUploadListSharedModule, AttachmentUploadsharedModule,SignatureFieldModule,EditAttachmentSharedModule
        ],
    declarations: [AdoptionComponent, AdoptionEligibilityDetailsComponent, AdoptionReportsComponent, AdoptionNarrativeComponent, AdoptionExtendedComponent, AdoptionEligibilityComponent, AdoptionSignatureFeildComponent, AdoptionApplicabilityDecisionComponent, AdoptionChildAssessmentComponent, AttachmentComponent],
    providers: [AdoptionResolverService],
    exports: [AdoptionChildAssessmentComponent]
})
export class AdoptionModule {}  