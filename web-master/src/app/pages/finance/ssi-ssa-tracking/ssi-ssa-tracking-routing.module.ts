import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SsiSsaTrackingComponent } from './ssi-ssa-tracking.component';
import { SsiSsaOverviewComponent } from './ssi-ssa-overview/ssi-ssa-overview.component';
import { SsiSsaSearchResultComponent } from './ssi-ssa-search-result/ssi-ssa-search-result.component';

const routes: Routes = [
  {
    path: '',
    component: SsiSsaTrackingComponent,
    children: [
      {
        path: 'search',
        component: SsiSsaSearchResultComponent
      },
      {
        path: ':clientid/ssi-ssa-overview',
        component: SsiSsaOverviewComponent
      },
      {
        path: '**',
        redirectTo: 'search'
      }
    ]
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SsiSsaTrackingRoutingModule { }
