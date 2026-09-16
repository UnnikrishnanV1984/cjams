import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonSearchComponent } from './person-search.component';
import { RoleGuard } from '../../@core/guard';
import { SearchComponent } from './search/search.component';
import { SearchResultComponent } from './search-result/search-result.component';
import { CwSearchComponent } from './cw-search/cw-search.component';
import { DemographicLogsComponent } from '../shared-pages/audit-trail/demographic-logs/demographic-logs.component';
import { AddressSearchComponent } from './address-search/address-search.component';

const routes: Routes = [
  {
    path: '',
    component: PersonSearchComponent,
    canActivate: [RoleGuard],
    children: [
      { path: 'search', component: SearchComponent },
      { path: 'search-result', component: SearchResultComponent },
      {
        path: 'cw-search',
        component: CwSearchComponent
      },
      {
        path: 'address-search',
        component: AddressSearchComponent
      },
      {
        path: 'demographic-log/:personid',
        component: DemographicLogsComponent
      }
    ],
    data: {
      screen: { modules: ['pages', 'menus'], skip: false }
    }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonSearchRoutingModule { }
