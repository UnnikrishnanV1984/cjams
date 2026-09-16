import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard } from '../../@core/guard';
import { ManageComponent } from './manage.component';

const routes: Routes = [
    {
        path: '',
        component: ManageComponent,
        canActivate: [RoleGuard],
        children: [
            { path: 'team-manage', loadChildren: () => import( './team-manage/team-manage.module').then(m => m.TeamManageModule) },
            { path: 'significant-events', loadChildren: () => import( './significant-events/significant-events.module').then(m => m.SignificantEventsModule) },
            { path: 'regulation-library', loadChildren: () => import( './regulation-library/regulation-library.module').then(m => m.RegulationLibraryModule) },
            { path: 'reference-links', loadChildren: () => import( './reference-links/reference-links.module').then(m => m.ReferenceLinksModule) },
            { path: 'person-merge', loadChildren: () => import( './person-merge/person-merge.module').then(m => m.PersonMergeModule) },
            { path: 'admin-help', loadChildren: () => import( './admin-help/admin-help.module').then(m => m.AdminHelpModule) },
            { path: 'non-contracting-providers', loadChildren: () => import( './non-contracting-providers/non-contracting-providers.module').then(m => m.NonContractingProvidersModule) },
            {
                path: 'news',
                loadChildren: () => import( './news/news.module').then(m => m.NewsModule),
                data: {
                    title: ['News'],
                    desc: 'Maryland department of human services',
                    screen: { key: 'manage.news', modules: [], skip: false }
                }
            },
            { path: 'manage-da-group', loadChildren: () => import( './manage-da-group/manage-da-group.module').then(m => m.ManageDaGroupModule) }
        ],
        data: {
            title: ['MDTHINK manage application'],
            desc: 'Maryland department of human services',
            screen: { current: 'manage', modules: [], skip: false }
        }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ManageRoutingModule {}
