import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ChildRemovalListComponent } from './child-removal-list.component';
import { ChildRemovalListRoutingModule } from './child-removal-list-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';
@NgModule({
  imports: [
    CommonModule,
    ChildRemovalListRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    PaginationModule
  ],
  declarations: [
    ChildRemovalListComponent
  ],
  providers: []
})
export class ChildRemovalListModule { }
