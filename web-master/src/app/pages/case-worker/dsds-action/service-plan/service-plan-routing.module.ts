import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServicePlanComponent } from './service-plan.component';
import { GoalStrategyComponent } from './goal-strategy/goal-strategy.component';
import { ServicePlanActivityComponent } from './service-plan-activity/service-plan-activity.component';
import { ServicePlanResolverService } from './service-plan-resolver-service';

const routes: Routes = [
    {
        path: '',
        component: ServicePlanComponent,
        // resolve: {
        //     result: ServicePlanResolverService
        // },
        children: [
            {
                path: 'goal-strategy',
                component: GoalStrategyComponent
            },
            {
                path: 'service-plan-activity',
                component: ServicePlanActivityComponent
            },
            { path: 'service-log-activity', loadChildren: () => import( './service-log-activity/service-log-activity.module').then(m => m.ServiceLogActivityModule) },
            { path: 'sc-gc', loadChildren: () => import( '././service-plan-core/service-plan-core.module').then(m => m.ServicePlanCoreModule) },
            { path: 'service-case-management', loadChildren: () => import( '../../../shared-pages/service-case-management/service-case-management.module').then(m => m.ServiceCaseManagementModule) },
            { path: 'youth-transition-plan', loadChildren: () => import( './youth-transition-plan/youth-transition-plan.module').then(m => m.YouthTransitionPlanModule)},
            { path: 'youth-transition-plan-new', loadChildren: () => import( './youth-transition-plan-new/youth-transition-plan.module').then(m => m.NewYouthTransitionPlanModule)},
            { path: 'plan-of-safecare', loadChildren: () => import( './plan-of-safecare/plan-of-safecare.module').then(m => m.PlanOfSafeCareModule)}
        ],
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ServicePlanRoutingModule {}
