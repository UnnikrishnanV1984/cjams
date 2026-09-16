import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeServiceTypeComponent } from './intake-service-type.component';

const routes: Routes = [
  {
      path: '',
      component: IntakeServiceTypeComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeServiceTypeRoutingModule { }
