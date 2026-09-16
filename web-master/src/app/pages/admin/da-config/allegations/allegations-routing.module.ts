import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../../../@core/guard';
import { AllegationsComponent } from './allegations.component';

const routes: Routes = [
    {
        path: '',
        component: AllegationsComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'allegation-configuration', loadChildren: () => import( './allegation-configuration/allegation-configuration.module').then(m => m.AllegationConfigurationModule) },
            { path: 'allegation-activities', loadChildren: () => import( './allegation-activities/allegation-activities.module').then(m => m.AllegationActivitiesModule) },
            { path: 'allegation-goals', loadChildren: () => import( './allegation-goals/allegation-goals.module').then(m => m.AllegationGoalsModule) },
            { path: 'allegation-mappings', loadChildren: () => import( './allegation-mappings/allegation-mappings.module').then(m => m.AllegationMappingsModule) },
            { path: 'allegation-tasks', loadChildren: () => import( './allegation-tasks/allegation-tasks.module').then(m => m.AllegationTasksModule) },
            { path: 'allegation-allegations', loadChildren: () => import( './allegation-allegations/allegation-allegations.module').then(m => m.AllegationAllegationsModule) },
            { path: 'assessment-score-usage', loadChildren: () => import( './assessment-score-usage/assessment-score-usage.module').then(m => m.AssessmentScoreUsageModule) },
            { path: '', redirectTo: 'allegation-configuration', pathMatch: 'full' }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class AllegationsRoutingModule {}
