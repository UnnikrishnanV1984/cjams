import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InvolvedPersonComponent } from './involved-person.component';
import { InvolvedPersonDhsActionComponent } from './involved-person-role-result/involved-person-dhs-action.component';
import { InvolvedPersonAddEditRoleComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-add-edit-role.component';
import { InvolvedPersonClearingCheckComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check.component';
import { InvolvedPersonClearingCheckSorComponent } from './involved-person-role-result/involved-person-clearing-check/involved-person-clearing-check-sor/involved-person-clearing-check-sor.component';
import { InvolvedPersonRoleProfileComponent } from './involved-person-role-result/involved-person-add-edit-role/involved-person-role-profile/involved-person-role-profile.component';
import { InvolvedPersonViewPersonComponent } from './involved-person-search/involved-person-view-person/involved-person-view-person.component';
import { InvolvedPersonSearchViewComponent } from './involved-person-search/involved-person-search-view.component';

const routes: Routes = [
    {
        path: '',
        component: InvolvedPersonComponent,
        children: [
            {
                path: 'dhs-action/:dhsid', component: InvolvedPersonDhsActionComponent

            },
            {
                path: 'dhs-action-edit/:personid/:actorid', component: InvolvedPersonAddEditRoleComponent,
                children: [
                    {
                        path: '', component: InvolvedPersonRoleProfileComponent
                    }
                ]
            },
            {
                path: 'dhs-action-clear', component: InvolvedPersonClearingCheckComponent,
                children: [
                    {
                        path: '', component: InvolvedPersonClearingCheckSorComponent
                    }
                ]
            },
            {
                path: 'dhs-action-view/:personid', component: InvolvedPersonSearchViewComponent,
                children: [
                    {
                        path: '', component: InvolvedPersonViewPersonComponent
                    }
                ]
            }
        ]
    },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class InvolvedPersonRoutingModule {}
