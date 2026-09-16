import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonBasicDetailsComponent } from './person-basic-details.component';
import { PersonNamesRelationsComponent } from './person-names-relations/person-names-relations.component';
import { PersonDemographicsComponent } from './person-demographics/person-demographics.component';

const routes: Routes = [
  {
    path: '',
    component: PersonBasicDetailsComponent,
    children: [
      {
        path: 'demographics',
        component: PersonDemographicsComponent
      },
      {
        path: 'names-relations',
        component: PersonNamesRelationsComponent
      },
      {
        path: '**',
        redirectTo: 'demographics'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonBasicDetailsRoutingModule { }
