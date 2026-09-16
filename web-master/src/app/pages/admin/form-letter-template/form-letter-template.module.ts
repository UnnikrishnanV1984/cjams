import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';


import { FormLetterTemplateRoutingModule } from './form-letter-template-routing.module';
import { FormLetterTemplateComponent } from './form-letter-template.component';
import { LibraryDocumentComponent } from './library-document.component';
import { MergeTemplateDocumentComponent } from './merge-template-document.component';
import { MergeTemplateDocumentMappingComponent } from './merge-template-document-mapping.component';

@NgModule({
  imports: [
    CommonModule,
    FormLetterTemplateRoutingModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [FormLetterTemplateComponent, LibraryDocumentComponent, MergeTemplateDocumentComponent, MergeTemplateDocumentMappingComponent]
})
export class FormLetterTemplateModule { }
