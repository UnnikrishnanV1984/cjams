import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlanComponent } from './plan.component';
import { SafetyPlanComponent } from './safety-plan/safety-plan.component';
import { ServiceLogComponent } from './service-log/service-log.component';
import { ServicePlanComponent } from './service-plan/service-plan.component';
import { SafetyPlanHistoryComponent } from './safety-plan-history/safety-plan-history.component';

const routes: Routes = [
    {
        path: '',
        component: PlanComponent,
        children: [
            {
                path: 'safety-plan',
                component: SafetyPlanComponent
            },
            {
                path: 'service-log',
                component: ServiceLogComponent
            },
            {
                path: 'service-plan',
                component: ServicePlanComponent
            },
            {
                path: 'safety-plan-history',
                component: SafetyPlanHistoryComponent
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PlanRoutingModule {}
