import { PlacementComponent } from './placement.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PermanencyPlanComponent } from './permanency-plan/permanency-plan.component';

const routes: Routes = [
    {
        path: '',
        component: PlacementComponent,
        children: [
            // { path: 'placement-add-edit', component: PlacementAddEditComponent },
            { path: 'permanency-plan', component: PermanencyPlanComponent },
            { path: 'placement-gap', loadChildren: () => import( './placement-gap/placement-gap.module').then(m => m.PlacementGapModule) },
            { path: 'appla', loadChildren: () => import( './appla-process/appla-process.module').then(m => m.ApplaProcessModule) },
            { path: 'adoption', loadChildren: () => import( './placement-adoption/placement-adoption.module').then(m => m.PlacementAdoptionModule) },
            { path: 'adoption-info', loadChildren: () => import( './placement-adoption-info/placement-adoption-info.module').then(m => m.PlacementAdoptionInfoModule) },
        ]
    }, {
        path: 'adoption-subsidy', loadChildren: () => import( './placement-adoption/adoption-subsidy/adoption-subsidy.module').then(m => m.AdoptionSubsidyModule)
    }
];


@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PlacementRoutingModule { }
