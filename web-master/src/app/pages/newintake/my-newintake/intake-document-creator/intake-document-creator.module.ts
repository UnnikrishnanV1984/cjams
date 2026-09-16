import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IntakeDocumentCreatorRoutingModule } from './intake-document-creator-routing.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
// import { CpsDocLetterComponent } from './cps-doc-letter/cps-doc-letter.component';
import { CpsDocLetterModule } from './cps-doc-letter/cps-doc-letter.module';

@NgModule({
  imports: [
    CommonModule,
    IntakeDocumentCreatorRoutingModule,
    FormMaterialModule,
    // SharedComponentsModule,
    SharedDirectivesModule,
    CpsDocLetterModule
    
  ],
  declarations:[]
})
export class IntakeDocumentCreatorModule { }
