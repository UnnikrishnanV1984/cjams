
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CwAssignmentsComponent } from './cw-assignments.component';
import { CwAssignmentsRoutingModule } from './cw-assignments-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CWAssignmentResolverService } from './cw-assignments-resolver.service';
@NgModule({
  imports: [
    CommonModule,
    CwAssignmentsRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    PaginationModule
  ],
  declarations: [
    CwAssignmentsComponent
  ],
  providers: [CWAssignmentResolverService]
})
export class CwAssignmentsModule { }
