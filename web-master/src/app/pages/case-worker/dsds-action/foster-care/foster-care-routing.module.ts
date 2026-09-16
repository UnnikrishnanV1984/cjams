import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FosterCareComponent } from './foster-care.component';
import { FosterCareSearchComponent } from './foster-care-search/foster-care-search.component';
import { FosterCareListComponent } from './foster-care-list/foster-care-list.component';
import { FosterCareReferalComponent } from './foster-care-referal/foster-care-referal.component';

const routes: Routes = [{
  path: '',
  component: FosterCareComponent,
  children: [
    { path: 'search', component: FosterCareSearchComponent },
    { path: 'list', component: FosterCareListComponent },
    { path: 'referal', component: FosterCareReferalComponent },
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FosterCareRoutingModule { }
