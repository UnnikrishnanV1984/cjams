import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SubsidyDownloadComponent } from './subsidy-download.component';

const routes: Routes = [{
  path: '',
  component: SubsidyDownloadComponent,
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SubsidyDownloadRoutingModule { }
