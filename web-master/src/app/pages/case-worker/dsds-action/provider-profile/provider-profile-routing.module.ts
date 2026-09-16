import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProviderProfileComponent } from './provider-profile.component';
const routes: Routes = [
    {
    path: '',
    component: ProviderProfileComponent
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderProfileRoutingModule { }
