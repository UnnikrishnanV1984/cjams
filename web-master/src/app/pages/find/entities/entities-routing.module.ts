import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RoleGuard } from '../../../@core/guard';
import { EntitiesComponent } from './entities.component';
import { EntitiesViewComponent } from './entities-view/entities-view.component';

const routes: Routes = [
  {
    path: '',
    component: EntitiesComponent,
    canActivate: [RoleGuard],
    data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] },
    children: [
      { path: 'showEntityDetails/:id', component: EntitiesViewComponent },
    ],
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EntitiesRoutingModule { }
