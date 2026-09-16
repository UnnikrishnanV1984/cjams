import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';

import { ReactiveFormsModule, FormsModule } from '@angular/forms';

import { IntakeCommunicationsRoutingModule } from './intake-communications-routing.module';
import { IntakeCommunicationsComponent } from './intake-communications.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { NotesComponent } from './notes/notes.component';
import { ResourceConsultComponent } from './resource-consult/resource-consult.component';
import { FamilyInvolvementMeetingComponent } from './family-involvement-meeting/family-involvement-meeting.component';

@NgModule({
  imports: [
    CommonModule,
    NgxMaskDirective,
    NgxMaskPipe,
    MatCheckboxModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatCardModule,
    MatInputModule,
    MatNativeDateModule,
    MatRadioModule,
    MatSelectModule,
    ReactiveFormsModule,
    FormsModule,
    QuillModule.forRoot(),
    PaginationModule,
    IntakeCommunicationsRoutingModule,
    FormMaterialModule,
    NgSelectModule,
    SharedPipesModule,
    ControlMessagesModule,
    // A2Edatetimepicker,
    SharedDirectivesModule
  ],
  declarations: [IntakeCommunicationsComponent, NotesComponent, ResourceConsultComponent, FamilyInvolvementMeetingComponent],
  providers: [DatePipe]
})
export class IntakeCommunicationsModule { }
