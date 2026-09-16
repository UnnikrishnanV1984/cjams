import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { QuillModule } from 'ngx-quill';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
// import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
// import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgxPrintModule } from 'ngx-print';
// import { MatChipsModule } from '@angular/material/chips';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { GuardianshipComponent } from './titleIVe-guardianship.component';
import { GuardianshipResolverService } from './titleIVe-guardianship-resolver.service';
import { TitleIveGapeligibilityComponent } from './title-ive-gapeligibility/title-ive-gapeligibility.component';
import { TitleIveGapextensionComponent } from './title-ive-gapextension/title-ive-gapextension.component';
import { TitleIveGapEligibilityDetailsComponent } from './title-ive-gap-eligibility-details/title-ive-gap-eligibility-details.component';
import { GuardianshipRoutingModule } from './titleIVe-guardianship-routing.module';
import { AttachmentComponent } from './attachment/attachment.component';
import {TitleIVeGuardianshipService} from './titleIVe-guardianship.service';
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
        // MatChipsModule,
        MatButtonModule,
        MatIconModule,
        // MatNativeDateModule,
        NgSelectModule,
        // A2Edatetimepicker,
        MatFormFieldModule,
        MatInputModule,
        MatSelectModule,
        MatRadioModule,
        MatTabsModule,
        MatCheckboxModule,
        MatListModule,
        // MatCardModule,
        MatButtonToggleModule,
        FormMaterialModule,
        MatTableModule,
        // MatExpansionModule,
        MatStepperModule,
        MatPaginatorModule, GuardianshipRoutingModule,
        MatDialogModule, MatFormFieldModule, CommonModule, QuillModule.forRoot(), FormsModule, ReactiveFormsModule, PaginationModule,
        MatAutocompleteModule, AngularSignaturePadModule, NgxPrintModule, ControlMessagesModule,
        MatMenuModule, 
        // SharedComponentsModule
        DocumentUploadListSharedModule, AttachmentUploadsharedModule,SignatureFieldModule,EditAttachmentSharedModule],
    declarations: [GuardianshipComponent, TitleIveGapeligibilityComponent, TitleIveGapextensionComponent,  TitleIveGapEligibilityDetailsComponent, AttachmentComponent],
    providers: [GuardianshipResolverService, TitleIVeGuardianshipService],
    exports: []
})
export class GuardianshipModule {}