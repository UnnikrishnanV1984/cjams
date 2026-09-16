import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProviderAddressComponent } from './provider-address.component';
const routes: Routes = [
  {
    path: '',
    component: ProviderAddressComponent,
    children: [
    ]
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProviderAddressRoutingModule { }
