import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RoleGuard } from '../../../@core/guard';
import { PersonHistoryDetailsComponent } from './person-history-details.component';
import { PersonLawEnfDetailsComponent } from './person-law-enf-details/person-law-enf-details.component';
import { ComplaintDetailsComponent } from './complaint-details/complaint-details.component';
import { CompliantDetailsResolverService } from './complaint-details/compliant-details-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: PersonHistoryDetailsComponent,
    children: [
      { path: 'history', component: PersonLawEnfDetailsComponent },
      { path: 'probation', loadChildren: () => import( '../person-probation/person-probation.module').then(m => m.PersonProbationModule) },
      {
        path: 'complaint-detail/:complaintid', component: ComplaintDetailsComponent,
        resolve: {
          complaintDetails: CompliantDetailsResolverService
        }
      },
      { path: '**', redirectTo: 'history' },
    ],
    canActivate: [RoleGuard],
    data: {
      screen: { modules: ['pages', 'menus'], skip: false }
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonHistoryDetailsRoutingModule { }
