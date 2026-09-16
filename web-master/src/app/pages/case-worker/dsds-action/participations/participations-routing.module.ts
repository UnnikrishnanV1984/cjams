import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ParticipationsComponent } from './participations.component';
import { ParticipationResolverService } from './participations-resolver-service';
const routes: Routes = [
    {
    path: '',
    component: ParticipationsComponent,
    // resolve: {
    //   result: ParticipationResolverService
    // }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ParticipationsRoutingModule { }
