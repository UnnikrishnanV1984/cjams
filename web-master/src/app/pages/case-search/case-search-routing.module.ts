import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseSearchComponent } from './case-search.component';
import { CaseSearchListComponent } from './case-search-list/case-search-list.component';
import { AuditTrailComponent } from '../shared-pages/audit-trail/audit-trail.component';

const routes: Routes = [
  {
    path: '',
    component: CaseSearchComponent,
    children: [
      {
        path: '',
        redirectTo: 'list',
        pathMatch: 'full',
      },
      {
        path : 'case-log/:caseid/:casenumber',
        component: AuditTrailComponent
      },
      {
        path: 'list',
        component: CaseSearchListComponent,
      }
    ]
   }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaseSearchRoutingModule { }
