import { ResourcesDetailsComponent } from './resources-details.component';
import { ResourcesSetupTreeComponent } from './resources-setup-tree.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ResourcesRoutingModule } from './resources-routing.module';
import { ResourcesComponent } from './resources.component';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

@NgModule({
  imports: [
    CommonModule,
    ResourcesRoutingModule,
    TreeModule,
    FormsModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    NgSelectModule,
    SharedPipesModule,
    // A2Edatetimepicker,
    PaginationModule
  ],
  declarations: [ResourcesComponent, ResourcesSetupTreeComponent, ResourcesDetailsComponent]
})
export class ResourcesModule { }
