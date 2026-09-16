import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TimeLineViewComponent } from './time-line-view.component';
import { TimeLineViewRoutingModule } from './time-line-view-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { TimeLineViewResolverService } from './time-line-view-resolver-service';
@NgModule({
  imports: [
    CommonModule,
    TimeLineViewRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker
  ],
  declarations: [
    TimeLineViewComponent
  ],
  providers: [TimeLineViewResolverService]
})
export class TimeLineViewModule { }
