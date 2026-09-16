import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TreeModule } from '@ali-hm/angular-tree-component';

import { TeamManageDetailComponent } from './team-manage-detail/team-manage-detail.component';
import { TeamManageRoutingModule } from './team-manage-routing.module';
import { TeamManageComponent } from './team-manage.component';

@NgModule({
  imports: [
    CommonModule,
    TeamManageRoutingModule,
    TreeModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [TeamManageComponent, TeamManageDetailComponent]
})
export class TeamManageModule { }
