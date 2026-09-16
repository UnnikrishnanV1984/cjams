import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonAssesmentsComponent } from './person-assesments.component';
import { PersonAssementsResolverService } from './person-assements-resolver.service';

const routes: Routes = [{
  path: '',
  component: PersonAssesmentsComponent,
  resolve: {
    items: PersonAssementsResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonAssesmentsRoutingModule { }
