import { RoleGuard } from '../../../@core/guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonsComponent } from './persons.component';
import { PersonSearchViewComponent } from './person-search-view/person-search-view.component';

const routes: Routes = [
  {
      path: '',
      component: PersonsComponent,
      canActivate: [RoleGuard],
      children: [
        { path: 'showPersonDetails/:id', component: PersonSearchViewComponent },
    ],
      data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonsRoutingModule { }
