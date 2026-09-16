import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TreeModule } from '@ali-hm/angular-tree-component';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { TeamPositionRoutingModule } from './team-position-routing.module';
import { TeamPositionComponent } from './team-position.component';
import { TeamSetupDetailComponent } from './team-setup-detail.component';
import { TeamSetupTreeComponent } from './team-setup-tree.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
  imports: [
    CommonModule,
    TeamPositionRoutingModule,
    TreeModule,
    FormsModule,
    ReactiveFormsModule,
    ControlMessagesModule,
    SharedDirectivesModule,
    NgSelectModule,
    SharedPipesModule,
    // A2Edatetimepicker,
    PaginationModule,
    MatDatepickerModule,
    MatFormFieldModule
  ],
  declarations: [TeamPositionComponent, TeamSetupTreeComponent, TeamSetupDetailComponent]
})
export class TeamPositionModule { }
