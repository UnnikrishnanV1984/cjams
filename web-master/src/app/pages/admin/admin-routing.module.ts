import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { RoleGuard, SeoGuard } from '../../@core/guard';
import { AdminComponent } from './admin.component';

const routes: Routes = [
    {
        path: '',
        component: AdminComponent,
        canActivate: [RoleGuard, SeoGuard],
        children: [
            { path: 'home', loadChildren: () => import( './dashboard/dashboard.module').then(m => m.DashboardModule) },
            { path: 'general', loadChildren: () => import( './general/general.module').then(m => m.GeneralModule) },
            { path: 'da-config', loadChildren: () => import( './da-config/da-config.module').then(m => m.DaConfigModule) },
            { path: 'recording-type', loadChildren: () => import( './recording-type/recording-type.module').then(m => m.RecordingTypeModule) },
            { path: 'non-contracting-type', loadChildren: () => import( './non-contracting-type/non-contracting-type.module').then(m => m.NonContractingTypeModule) },
            { path: 'equipment-management', loadChildren: () => import( './equipment-management/equipment-management.module').then(m => m.EquipmentManagementModule) },
            { path: 'fiscal-category', loadChildren: () => import( './fiscal-category/fiscal-category.module').then(m => m.FiscalCategoryModule)},
            { path: 'maintain-service-structures', loadChildren: () => import( './maintain-service-structures/maintain-service-structures.module').then(m => m.MaintainServiceStructuresModule)},
            { path: 'batch-annual-application', loadChildren: () => import( './batch-annual-application/batch-annual-application.module').then(m => m.BatchAnnualApplicationModule) },
            { path: 'user-security-profile', loadChildren: () => import( './user-security-profile/user-security-profile.module').then(m => m.UserSecurityProfileModule) },
            { path: 'form-letter-template', loadChildren: () => import( './form-letter-template/form-letter-template.module').then(m => m.FormLetterTemplateModule) },
            { path: 'assessment-builder', loadChildren: () => import( './assessment-builder/assessment-builder.module').then(m => m.AssessmentBuilderModule) },
            { path: 'contracting', loadChildren: () => import( './contracting/contracting.module').then(m => m.ContractingModule) },
            { path: 'team-position', loadChildren: () => import( './team-position/team-position.module').then(m => m.TeamPositionModule) },
        ],
        data: {
            title: ['MDTHINK Admin configurations'],
            desc: 'Maryland department of human services',
            screen: { current: 'admin', modules: [], skip: false }
        }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class AdminRoutingModule { }
