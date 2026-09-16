import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InfoAdoptiveFamilyComponent } from './info-adoptive-family.component';

const routes: Routes = [
  {
    path: '',
    component: InfoAdoptiveFamilyComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InfoAdoptiveFamilyRoutingModule { }
