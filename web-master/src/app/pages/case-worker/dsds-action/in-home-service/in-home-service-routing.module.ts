import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InHomeServiceComponent } from './in-home-service.component';
import { ProgressReviewComponent } from './progress-review/progress-review.component';
import { ServiceAgreementComponent } from './service-agreement/service-agreement.component';
import {InHomeServiceResolverService} from './in-home-service-resolver-service'

const routes: Routes = [
    {
        path: '',
        component: InHomeServiceComponent,
        // resolve: {
        //     result: InHomeServiceResolverService
        //   },
        children: [
            {
                 path: 'progress-review', component: ProgressReviewComponent

            },
            {
                path: 'service-agreement', component: ServiceAgreementComponent
           }
        ]
    },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class InHomeServiceRoutingModule {}
