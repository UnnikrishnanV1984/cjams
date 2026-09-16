import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminHelpComponent } from './admin-help.component';

const routes: Routes = [
  {
    path: '',
    component: AdminHelpComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminHelpRoutingModule { }
