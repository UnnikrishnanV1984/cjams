import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AssessmentComponent } from './assessment.component';
import { AssessmentRoutingModule } from './assessment-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatSelectModule } from '@angular/material/select';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { AssessmentResolverService } from './assessment-resolver-service';
import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { MatMomentDatetimeModule } from '@mat-datetimepicker/moment';
import { MatDatetimepickerModule } from '@mat-datetimepicker/core';

@NgModule({
  imports: [
    CommonModule,
    AssessmentRoutingModule,
    MatRadioModule,
    MatDatepickerModule,
    MatSelectModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    SharedComponentsModule,
    PaginationModule,
    MatMomentDatetimeModule, MatDatetimepickerModule
  ],
  declarations: [
    AssessmentComponent
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  providers: [AssessmentResolverService]
})
export class AssessmentModule { }
