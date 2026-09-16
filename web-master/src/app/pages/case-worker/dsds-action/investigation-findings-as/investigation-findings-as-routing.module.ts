import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InvestigationFindingsAsComponent } from './investigation-findings-as.component';

const routes: Routes = [
  {
    path: '',
    component: InvestigationFindingsAsComponent,

  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InvestigationFindingsAsRoutingModule { }
