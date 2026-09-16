import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { StaffMangementComponent } from './staff-mangement/staff-mangement.component';


const routes: Routes = [{
  path: '',
  component: StaffMangementComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class StaffManagementRoutingModule { }
