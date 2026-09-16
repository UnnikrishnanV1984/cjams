import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InHomeServiceRoutingModule } from './in-home-service-routing.module';
import { InHomeServiceComponent } from './in-home-service.component';
import { ServiceAgreementComponent } from './service-agreement/service-agreement.component';
import { ProgressReviewComponent } from './progress-review/progress-review.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { QuillModule } from 'ngx-quill';
import { PersonService } from './person.service';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import {InHomeServiceResolverService} from './in-home-service-resolver-service'
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    InHomeServiceRoutingModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    ControlMessagesModule, NgSelectModule,
    SortTableModule,
    PaginationModule.forRoot(),
    SharedPipesModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  declarations: [InHomeServiceComponent, ServiceAgreementComponent, ProgressReviewComponent],
  providers: [PersonService,InHomeServiceResolverService,provideNgxMask()]

})
export class InHomeServiceModule { }
