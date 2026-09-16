import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServiceLogActivityComponent } from '../service-log-activity/service-log-activity.component';
import { AgencyProvidedServicesComponent } from '../service-log-activity/agency-provided-services/agency-provided-services.component';
import { ReferredServicesComponent} from '../service-log-activity/referred-services/referred-services.component';


const routes: Routes = [
    {
        path: '',
        component: ServiceLogActivityComponent,
        children: [
            {
                path: 'agency-provided-services',
                component: AgencyProvidedServicesComponent
            },
            {
                path: 'referred-services',
                component: ReferredServicesComponent
            },
            {
                path: '',
                redirectTo: 'referred-services',
                pathMatch: 'full'
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ServiceLogActivityRoutingModule {}
