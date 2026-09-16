import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NarrativeRoutingModule } from './narrative-routing.module';
import { NarrativeComponent } from './narrative.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { QuillModule } from 'ngx-quill';
import { FormsModule } from '@angular/forms';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { NarrativeResolverService } from './narrative-resolver-service';

@NgModule({
  imports: [
    SharedDirectivesModule,
    CommonModule, 
    NarrativeRoutingModule,
    FormsModule,
    FormMaterialModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    QuillModule.forRoot(),
    MatAutocompleteModule,
    NgxMaskDirective,
    NgxMaskPipe
 
  ],
    exports: [NarrativeComponent],
  declarations: [NarrativeComponent],
  providers : [NarrativeResolverService,provideNgxMask()]
})
export class NarrativeModule { }
