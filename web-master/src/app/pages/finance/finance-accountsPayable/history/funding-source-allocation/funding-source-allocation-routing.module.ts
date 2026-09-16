import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FundingSourceAllocationComponent } from './funding-source-allocation.component';
import { FundingAllocationResultComponent } from './funding-allocation-result/funding-allocation-result.component';
import { FundingAllocationDetailsComponent } from './funding-allocation-details/funding-allocation-details.component';

const routes: Routes = [
  {
    path: '',
    component: FundingSourceAllocationComponent,
    children: [
      {
        path: 'search',
        component: FundingAllocationResultComponent
      },
      {
        path: 'details',
        component: FundingAllocationDetailsComponent
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
export class FundingSourceAllocationRoutingModule { }
