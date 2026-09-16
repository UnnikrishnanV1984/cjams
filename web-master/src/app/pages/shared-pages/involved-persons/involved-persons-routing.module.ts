import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { InvolvedPersonsComponent } from './involved-persons.component';
import { PersonsGridCwComponent } from './persons-grid-cw/persons-grid-cw.component';
import { InvolvedPersonsResolverService } from './involved-persons-resolver.service';

const routes: Routes = [{
  path: '',
  component: InvolvedPersonsComponent,
  resolve: {
    result: InvolvedPersonsResolverService
  },
  children: [
    {
      path: '',
      redirectTo: 'list',
      pathMatch: 'full',
    },
    {
      path: 'list',
      component: PersonsGridCwComponent
    },
    {
      path: 'find-individual',
      loadChildren: () => import( './find-individual/find-individual.module').then(m => m.FindIndividualModule)
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class InvolvedPersonsRoutingModule { }
