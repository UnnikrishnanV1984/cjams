import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Supervisor4eComponent } from './supervisor4e/supervisor4e.component';
import { Worker4eComponent } from './worker4e/worker4e.component';
import { PeriodTablePopUpComponent } from './period-table-pop-up/period-table-pop-up.component';
import { TitleIveFosterCarComponent } from './title-ive-foster-car/title-ive-foster-car.component';
import { IveAfcarsReportComponent } from './iveafcarsreport/ive-afcars-report.component';
import { IveCSMSReportComponent } from './ivecsmsreport/ive-csms-report.component';
import { Dashboard4eComponent } from './dashboard4e/dashboard4e.component';
const savedintakestitle = 'MDTHINK - Saved Intakes';
const descvalue = 'Maryland department of human services';
const routes: Routes = [
    {
        path: '',
        //component: Worker4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        children: [
            {
                path: 'dashboard4e',
                loadChildren: () => import( './title4e.module').then(m => m.Title4eModule)
            }
        ]
    },
    {
        path: 'supervisor4e',
       // component: Supervisor4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
   
    {
        path: 'assistadmin4e',
        //component: Supervisor4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'qa4e',
       // component: Supervisor4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'admin4e',
     //   component: Supervisor4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'worker4e',
      //  component: Worker4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'analyst4e',
        //component: Worker4eComponent,
        component: Dashboard4eComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'foster-car/:clientId/:removalId',
        component: TitleIveFosterCarComponent,
        // canActivate: [RoleGuard],
        data: {
            title: ['MDTHINK - Title IV-E Foster Care'],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'guardianship/:clientid/:removalId',
        loadChildren: () => import( './guardianship/titleIVe-guardianship.module').then(m => m.GuardianshipModule),
    },
    {
        path: 'adoption/:clientid/:removalId',
        loadChildren: () => import( './adoption/titleIVe-adoption.module').then(m => m.AdoptionModule)
    },
    {
        path: 'aca/:clientid/:removalId',
        loadChildren: () => import( './adoption/titleIVe-adoption.module').then(m => m.AdoptionModule)
    },
    {
        path: 'ive-afcarsreport',
        component: IveAfcarsReportComponent,
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'ive-csmsreport',
        component: IveCSMSReportComponent,
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
    {
        path: 'period-table-pop-up',
        component: PeriodTablePopUpComponent,
        // canActivate: [RoleGuard],
        data: {
            title: [savedintakestitle],
            desc: descvalue,
            screen: { current: 'new', modules: [], skip: false }
        }
    },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class Title4eRoutingModule {}
