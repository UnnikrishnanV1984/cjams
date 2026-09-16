import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { ActionsTasksGoalsRoutingModule } from './actions-tasks-goals-routing.module';
import { ActionsTasksGoalsComponent } from './actions-tasks-goals.component';

@NgModule({
    imports: [CommonModule, ActionsTasksGoalsRoutingModule],
    declarations: [ActionsTasksGoalsComponent]
})
export class ActionsTasksGoalsModule {}
