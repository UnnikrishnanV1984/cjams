import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
// import { A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';

import { InvolvedPersonRoutingModule } from './involved-person-routing.module';
import { InvolvedPersonComponent } from './involved-person.component';
import { InvolvedPersonRoleResultComponent } from './involved-person-role-result/involved-person-role-result.component';
import { InvolvedPersonSearchComponent } from './involved-person-search/involved-person-search.component';
import { InvolvedPersonAddEditRoleComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-add-edit-role.component';
import { InvolvedPersonClearingCheckComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check.component';
import { InvolvedPersonRoleProfileComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-profile/involved-person-role-profile.component';
import { InvolvedPersonRoleAddressComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-address/involved-person-role-address.component';
// tslint:disable-next-line:max-line-length
import { InvolvedPersonRoleRoleOfPersonComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-role-of-person/involved-person-role-role-of-person.component';
// tslint:disable-next-line:max-line-length
import { InvolvedPersonRoleDangerToWorkerComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-danger-to-worker/involved-person-role-danger-to-worker.component';
// tslint:disable-next-line:max-line-length
import { InvolvedPersonRoleDangerAtLocationComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-danger-at-location/involved-person-role-danger-at-location.component';
import { InvolvedPersonClearingCheckSorComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check-sor/involved-person-clearing-check-sor.component';
import { InvolvedPersonClearingCheckDmhComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check-dmh/involved-person-clearing-check-dmh.component';
import { InvolvedPersonClearingCheckEdlComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check-edl/involved-person-clearing-check-edl.component';
import { InvolvedPersonDhsActionComponent } from './involved-person-role-result/involved-person-dhs-action.component';
import { InvolvedPersonViewPersonComponent } from './involved-person-search/involved-person-view-person/involved-person-view-person.component';
import { InvolvedPersonViewAddressInformationComponent } from './involved-person-search/involved-person-view-address-information/involved-person-view-address-information.component';
import { InvolvedPersonViewDhsActionComponent } from './involved-person-search/involved-person-view-dhs-action/involved-person-view-dhs-action.component';
import { InvolvedPersonViewClearingComponent } from './involved-person-search/involved-person-view-clearing/involved-person-view-clearing.component';
import { InvolvedPersonViewInvolvedEntityComponent } from './involved-person-search/involved-person-view-involved-entity/involved-person-view-involved-entity.component';
import { ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { InvolvedPersonSearchViewComponent } from './involved-person-search/involved-person-search-view.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';

@NgModule({
  imports: [
    CommonModule,
    InvolvedPersonRoutingModule,
    ReactiveFormsModule,
    SharedDirectivesModule,
    PaginationModule,
    NgSelectModule,
    // A2Edatetimepicker,
    SharedPipesModule,
    NgxMaskDirective,
    NgxMaskPipe,
    GlobalPopupModule
    
  ],
  providers:[provideNgxMask()],
  // tslint:disable-next-line:max-line-length
  declarations: [InvolvedPersonComponent, InvolvedPersonRoleResultComponent, InvolvedPersonSearchComponent, InvolvedPersonAddEditRoleComponent, InvolvedPersonClearingCheckComponent, InvolvedPersonRoleProfileComponent, InvolvedPersonRoleAddressComponent, InvolvedPersonRoleRoleOfPersonComponent, InvolvedPersonRoleDangerToWorkerComponent, InvolvedPersonRoleDangerAtLocationComponent, InvolvedPersonClearingCheckSorComponent, InvolvedPersonClearingCheckDmhComponent, InvolvedPersonClearingCheckEdlComponent, InvolvedPersonDhsActionComponent, InvolvedPersonViewPersonComponent, InvolvedPersonViewAddressInformationComponent, InvolvedPersonViewDhsActionComponent, InvolvedPersonViewClearingComponent, InvolvedPersonViewInvolvedEntityComponent, InvolvedPersonSearchViewComponent]
})
export class InvolvedPersonModule { }
