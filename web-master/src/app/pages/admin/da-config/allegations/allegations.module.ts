import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SortTableModule } from '../../../../shared/modules/sortable-table/sortable-table.module';
import { AllegationActivitiesModule } from './allegation-activities/allegation-activities.module';
import { AllegationAllegationsModule } from './allegation-allegations/allegation-allegations.module';
import { AllegationConfigurationModule } from './allegation-configuration/allegation-configuration.module';
import { AllegationGoalsModule } from './allegation-goals/allegation-goals.module';
import { AllegationMappingsModule } from './allegation-mappings/allegation-mappings.module';
import { AllegationTasksModule } from './allegation-tasks/allegation-tasks.module';
import { AllegationsRoutingModule } from './allegations-routing.module';
import { AllegationsComponent } from './allegations.component';
import { AssessmentScoreUsageModule } from './assessment-score-usage/assessment-score-usage.module';

@NgModule({
    imports: [
        CommonModule,
        AllegationsRoutingModule,
        AllegationConfigurationModule,
        AllegationActivitiesModule,
        AllegationAllegationsModule,
        AllegationGoalsModule,
        AllegationMappingsModule,
        AllegationTasksModule,
        AssessmentScoreUsageModule,
        SortTableModule,
        SharedPipesModule,
        SharedDirectivesModule
    ],
    declarations: [AllegationsComponent]
})
export class AllegationsModule { }
