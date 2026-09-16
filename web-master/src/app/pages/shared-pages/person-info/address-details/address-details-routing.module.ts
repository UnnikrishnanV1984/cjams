import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddressDetailsComponent } from './address-details.component';
import { AddAddressComponent } from './add-address/add-address.component';
import { ListAddressComponent } from './list-address/list-address.component';

const routes: Routes = [
  {
    path: '',
    component: AddressDetailsComponent
  },
  {
    path: 'add',
    component: AddAddressComponent
  },
  {
    path: 'list',
    component: ListAddressComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AddressDetailsRoutingModule { }
