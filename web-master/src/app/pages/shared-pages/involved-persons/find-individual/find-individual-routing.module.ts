import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FindIndividualComponent } from './find-individual.component';
import { SearchResultComponent } from './search-result/search-result.component';
import { CwSearchComponent } from '../../../../pages/person-search/cw-search/cw-search.component';

const routes: Routes = [{
  path: '',
  component: FindIndividualComponent,
  children: [
    {
      path: 'search',
      component: CwSearchComponent,
      data: { selectionUX: true }
    },
    {
      path: 'search-result',
      component: CwSearchComponent,
      data: { selectionUX: true }
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FindIndividualRoutingModule { }
