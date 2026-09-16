import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { FormLetterTemplateComponent } from './form-letter-template.component';

const routes: Routes = [{
  path: '',
  component: FormLetterTemplateComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FormLetterTemplateRoutingModule { }
