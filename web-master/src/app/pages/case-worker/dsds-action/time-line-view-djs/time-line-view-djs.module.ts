import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TimeLineViewDjsComponent } from './time-line-view-djs.component';
import { TimeLineViewDjsRoutingModule } from './time-line-view-djs-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
@NgModule({
  imports: [
    CommonModule,
    TimeLineViewDjsRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
  ],
  declarations: [
    TimeLineViewDjsComponent
  ],
  providers: []
})
export class TimeLineViewDjsModule { }
