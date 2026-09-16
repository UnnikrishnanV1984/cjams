import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonDisabilityComponent } from './person-disability.component';
import { DisabilityListComponent } from './disability-list/disability-list.component';
import { DisabilityCreateUpdateComponent } from './disability-create-update/disability-create-update.component';
import { PersonDisabilityResolverService } from './person-disability-resolver.service';

const routes: Routes = [{
  path: ':personid',
  component: PersonDisabilityComponent,
  resolve: {
    personDetails: PersonDisabilityResolverService
  },
  children: [
    {
      path : 'list',
      component: DisabilityListComponent
    },
    {
      path : 'create',
      component: DisabilityCreateUpdateComponent
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonDisabilityRoutingModule { }
