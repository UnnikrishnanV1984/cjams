import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocumentsRoutingModule } from './documents-routing.module';
import { DocumentHeaderComponent } from './document-header/document-header.component';

@NgModule({
  imports: [
    CommonModule,
    DocumentsRoutingModule
  ],
  declarations: [DocumentHeaderComponent],
  exports: [DocumentHeaderComponent]
})
export class DocumentsModule { }
