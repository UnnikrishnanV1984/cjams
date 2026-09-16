import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TransportComponent } from './transport.component';
import { TransportService } from './transport.service';
import { TransportAddEditComponent } from './transport-add-edit/transport-add-edit.component';

const routes: Routes = [
  {
    path: '',
    component: TransportComponent
  },
  {
    path: ':operation/:transportid',
    component: TransportAddEditComponent
  },
  {
    path: ':operation',
    component: TransportAddEditComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [TransportService]
})
export class TransportRoutingModule { }
