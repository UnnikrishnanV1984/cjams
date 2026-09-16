import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonAlertsComponent } from './person-alerts.component';
import { PersonAlertListComponent } from './person-alert-list/person-alert-list.component';
import { PersonAlertDetailsComponent } from './person-alert-details/person-alert-details.component';
import { PersonAlertsService } from './person-alerts.service';

const routes: Routes = [
  {
    path: '',
    component: PersonAlertsComponent,
    children: [
      {
        path: 'list',
        component: PersonAlertListComponent
      },
      {
        path: ':operation',
        component: PersonAlertDetailsComponent
      },
      {
        path: '**',
        redirectTo: 'list'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [PersonAlertsService]
})
export class PersonAlertsRoutingModule { }
