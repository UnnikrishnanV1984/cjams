import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { CustomFormsComponent } from './custom-forms.component';

const routes: Routes = [
  {
    path: '',
    component: CustomFormsComponent,
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CustomFormsRoutingModule { }
