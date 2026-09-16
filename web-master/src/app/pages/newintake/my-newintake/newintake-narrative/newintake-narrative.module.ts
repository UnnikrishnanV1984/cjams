import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { NewintakeNarrativeRoutingModule } from './newintake-narrative-routing.module';
import { NewintakeNarrativeComponent } from './newintake-narrative.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { QuillModule } from 'ngx-quill';
import { FormsModule } from '@angular/forms';
import { PopoverModule } from 'ngx-bootstrap/popover';

@NgModule({
  imports: [
    SharedDirectivesModule,
    CommonModule,
    NewintakeNarrativeRoutingModule,
    FormsModule,
    FormMaterialModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    QuillModule.forRoot(),
    PopoverModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  providers:[provideNgxMask()],
  declarations: [NewintakeNarrativeComponent]
})
export class NewintakeNarrativeModule { }
