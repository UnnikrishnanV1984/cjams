import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AsMaltreatmentInformationComponent } from './as-maltreatment-information.component';

const routes: Routes = [{
  path: '',
  component: AsMaltreatmentInformationComponent
}
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AsMaltreatmentInformationRoutingModule { }
