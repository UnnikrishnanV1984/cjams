import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { ResourceNewComponent } from './resource-new.component';
import { ResourceNewDetailsComponent } from './resource-new-details/resource-new-details.component';
import { ResourceNewSetupTreeComponent } from './resource-new-setup-tree/resource-new-setup-tree.component';
import { ResourceNewRoutingModule } from'./resources-new-routing.module';

@NgModule({
  imports: [
    CommonModule,
    TreeModule,
    FormsModule,
    ResourceNewRoutingModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    NgSelectModule,
    SharedPipesModule,
    // A2Edatetimepicker,
    PaginationModule
  ],
  declarations: [ResourceNewComponent, ResourceNewDetailsComponent, ResourceNewSetupTreeComponent]
})
export class ResourcenewModule { }
