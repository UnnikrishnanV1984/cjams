import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MaltreatmentInformationComponent } from './maltreatment-information.component';
import { MaltreatmentAllegationResolverService } from './maltreatment-information-resolver.service';

const routes: Routes = [{
  path: '',
  component: MaltreatmentInformationComponent,
//   resolve: {
//     result: MaltreatmentAllegationResolverService
// }
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MaltreatmentInformationRoutingModule { }
