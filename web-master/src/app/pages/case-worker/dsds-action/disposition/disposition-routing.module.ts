import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { DispositionComponent } from './disposition.component';
import { DispositionResolverService } from './disposition-resolver.service';
const routes: Routes = [
    {
    path: '',
    component: DispositionComponent,
    // resolve: {
    //   result: DispositionResolverService
    // }
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DispositionRoutingModule { }
