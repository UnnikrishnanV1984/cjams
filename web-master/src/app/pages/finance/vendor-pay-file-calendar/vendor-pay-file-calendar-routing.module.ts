import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { VendorPayFileCalendarComponent } from './vendor-pay-file-calendar.component';

const routes: Routes = [
  {
      path: '',
      component: VendorPayFileCalendarComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class VendorPayFileCalendarRoutingModule { }
