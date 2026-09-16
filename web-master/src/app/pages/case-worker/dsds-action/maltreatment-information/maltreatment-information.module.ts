import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
// tslint:disable-next-line:max-line-length


import { MaltreatmentInformationRoutingModule } from './maltreatment-information-routing.module';
import { MaltreatmentInformationComponent } from './maltreatment-information.component';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { MaltreatmentAllegationResolverService } from './maltreatment-information-resolver.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
    imports: [
        CommonModule,
        FormMaterialModule,
        MaltreatmentInformationRoutingModule,
        // A2Edatetimepicker,
        SharedDirectivesModule,
        PaginationModule
    ],
    declarations: [MaltreatmentInformationComponent],
    providers: [MaltreatmentAllegationResolverService]
})
export class MaltreatmentInformationModule {}
