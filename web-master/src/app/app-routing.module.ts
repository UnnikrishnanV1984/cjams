import { NgModule } from '@angular/core';
import { Routes, RouterModule, NoPreloading } from '@angular/router';
import { AppComponent } from './app.component';
import { AuthGuard, SeoGuard } from './@core/guard';
import { PagesModule } from './pages/pages.module';
import { LoginModule } from './auth/login/login.module';

const desc = 'Maryland department of human services';
export const routes: Routes = [
    {
        path: '',
        redirectTo: 'pages',
        pathMatch: 'full'
    },
    // {
    //     path: '',
    //     loadChildren: () => import( './pages/pages.module').then(m => m.PagesModule),
    //     canActivate: [SeoGuard],
    //     data: {
    //         title: ['MDTHINK Home'],
    //         desc: desc
    //     }
    // },
    {
        path: 'external-assessment/:servicereqid/:isApproved/:templateId/:submissionId',
        loadComponent: () => import( './external-assessment/external-assessment.component').then(m => m.ExternalAssessmentComponent),
    },
    {
        path: 'external-assessment/:servicereqid/:isApproved/:templateId/:submissionId/:intakeservicerequestactorid',
        loadComponent: () => import( './external-assessment/external-assessment.component').then(m => m.ExternalAssessmentComponent),
    },
    {
        path: 'pages',
        loadChildren: () => import( './pages/pages.module').then(m => m.PagesModule),
        // loadChildren: () => PagesModule,
        canActivate: [AuthGuard, SeoGuard],
        data: {
            title: ['MDTHINK Home'],
            desc: desc
        }
    },
    {
        path: 'login',
        loadChildren: () => import( './auth/login/login.module').then(m => m.LoginModule),
        // loadComponent: () => import( './auth/login/login.component').then(m => m.LoginComponent),
        canActivate: [SeoGuard],
        data: {
            title: ['MDTHINK Login'],
            desc: desc
        }
    },
   
    { path: 'error', loadComponent: () => import('./shared/pages/server-error/server-error.component').then(m => m.ServerErrorComponent) },
    { path: 'access-denied', loadComponent: () => import('./shared/pages/access-denied/access-denied.component').then(m => m.AccessDeniedComponent) },
    { path: 'not-found', loadComponent: () => import('./shared/pages/not-found/not-found.component').then(m => m.NotFoundComponent) },
    { path: '**', redirectTo: 'not-found' }
];