import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SdmComponent } from './sdm.component';
import { SDMResolverService } from './sdm-resolver.service';
const routes: Routes = [
  {
    path: '',
    component: SdmComponent,
    // resolve: {
    //   result: SDMResolverService
    // }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SdmRoutingModule { }
