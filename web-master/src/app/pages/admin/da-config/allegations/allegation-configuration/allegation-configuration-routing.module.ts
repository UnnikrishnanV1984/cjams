import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AllegationConfigurationComponent } from './allegation-configuration.component';

const routes: Routes = [
  {
    path: '',
    component: AllegationConfigurationComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AllegationConfigurationRoutingModule { }
