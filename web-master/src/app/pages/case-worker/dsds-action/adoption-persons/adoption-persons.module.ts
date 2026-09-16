import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { AdoptionPersonsRoutingModule } from './adoption-persons-routing.module';
import { AdoptionPersonsComponent } from './adoption-persons.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { QuillModule } from 'ngx-quill';
import { FormsModule } from '@angular/forms';
import { MatAutocompleteModule } from '@angular/material/autocomplete';

@NgModule({
  imports: [
    SharedDirectivesModule,
    CommonModule, 
    AdoptionPersonsRoutingModule,
    FormsModule,
    FormMaterialModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    QuillModule.forRoot(),
    MatAutocompleteModule,
    NgxMaskDirective,
    NgxMaskPipe
 
  ],
  providers:[provideNgxMask()],
  exports: [AdoptionPersonsComponent],
  declarations: [AdoptionPersonsComponent]
})
export class AdoptionPersonsModule { }
