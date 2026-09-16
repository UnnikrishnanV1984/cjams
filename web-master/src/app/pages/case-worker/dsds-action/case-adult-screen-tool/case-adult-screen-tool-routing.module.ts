import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaseAdultScreenToolComponent } from './case-adult-screen-tool.component';

const routes: Routes = [{
  path: '',
  component: CaseAdultScreenToolComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaseAdultScreenToolRoutingModule { }
