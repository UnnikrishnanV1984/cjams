import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServiceFosterCareComponent } from './service-foster-care.component';
const routes: Routes = [
    {
    path: '',
    component: ServiceFosterCareComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ServiceFosterCareRoutingModule { }
