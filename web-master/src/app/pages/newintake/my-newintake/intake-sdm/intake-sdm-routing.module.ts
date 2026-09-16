import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeSdmComponent } from './intake-sdm.component';

const routes: Routes = [
  {
      path: '',
      component: IntakeSdmComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeSdmRoutingModule { }
