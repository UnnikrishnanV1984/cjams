import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ParticipationsComponent } from './participations.component';
import { ParticipationsRoutingModule } from './participations-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import { ParticipationResolverService } from './participations-resolver-service';

@NgModule({
  imports: [
    CommonModule,
    ParticipationsRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot()
  ],
  declarations: [
    ParticipationsComponent
  ],
  providers: [ParticipationResolverService]
})
export class ParticipationsModule { }
