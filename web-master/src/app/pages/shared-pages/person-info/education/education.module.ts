import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { EducationRoutingModule } from './education-routing.module';
import { EducationComponent } from './education.component';
import { AddEducationComponent } from './add-education/add-education.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ShareFeaturesModule } from '../share-features/share-features.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import {EducationInfoService} from './education.service';
import { ListEducationComponent } from './list-education/list-education.component'
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { DsdsService } from '../../../../pages/case-worker/dsds-action/_services/dsds.service';
import { DocumentUploadListSharedModule } from '../../../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.module';
import { AttachmentUploadsharedModule } from '../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.module';

@NgModule({ declarations: [EducationComponent, AddEducationComponent, ListEducationComponent], imports: [CommonModule,
        EducationRoutingModule,
        FormMaterialModule,
        ShareFeaturesModule,
        PopoverModule,
        // SharedComponentsModule,
        NgxMaskDirective,
        NgxMaskPipe, DocumentUploadListSharedModule, AttachmentUploadsharedModule
], providers: [EducationInfoService, DsdsService, provideNgxMask(), provideHttpClient(withInterceptorsFromDi())] })
export class EducationModule {
 }