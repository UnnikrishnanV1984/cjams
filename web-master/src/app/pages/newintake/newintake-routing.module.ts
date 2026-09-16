import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { IntakeUtils } from '../_utils/intake-utils.service';
import { NewSaveintakeComponent } from './new-saveintake/new-saveintake.component';
import { NewintakeComponent } from './newintake.component';
import { PurposeResolverService } from './my-newintake/purpose-resolver.service';
import { RoleGuard } from '../../@core/guard';

const routes: Routes = [
    {
        path: '',
        component: NewintakeComponent,
        canActivate: [RoleGuard],
        children: [
            {
                path: 'my-newintake',
                loadChildren: () => import( './my-newintake/my-newintake.module').then(m => m.MyNewintakeModule)
            }
        ]
    },
    {
        path: 'new-saveintake',
        component: NewSaveintakeComponent,
        canActivate: [RoleGuard],
        data: {
            title: ['MDTHINK - Saved Intakes'],
            desc: 'Maryland department of human services',
            screen: { current: 'new', key: 'myintake-module', modules: [], skip: false }
        },
        // resolve: {
        //     purposeList: PurposeResolverService,
        // }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule],
    providers: [IntakeUtils]
})
export class NewintakeRoutingModule {}
