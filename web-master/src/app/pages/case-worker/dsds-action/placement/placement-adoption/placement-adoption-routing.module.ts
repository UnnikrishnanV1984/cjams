import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementAdoptionComponent } from './placement-adoption.component';
import { AdoptionTprRecomendationComponent } from './adoption-tpr-recomendation/adoption-tpr-recomendation.component';
import { AdoptionLegalCustodyComponent } from './adoption-legal-custody/adoption-legal-custody.component';
import { AdoptionTprComponent } from './adoption-tpr/adoption-tpr.component';
import { AdoptionComponent } from '../../../../title4e/adoption/titleIVe-adoption.component';
import { PlacementAdoptionResolverService } from './placement-adoption-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: PlacementAdoptionComponent,
    children: [
      // { path: 'placement-add-edit', component: PlacementAddEditComponent },
      { path: 'title-4e', component: AdoptionComponent },
      { path: 'tpr-recom', component: AdoptionTprRecomendationComponent },
      { path: 'legal-custody', component: AdoptionLegalCustodyComponent },
      { path: 'tpr', component: AdoptionTprComponent },
      { path: 'planning', loadChildren: () => import( './adoption-planning/adoption-planning.module').then(m => m.AdoptionPlanningModule) },
      { path: 'break-the-line', loadChildren: () => import( './placement-breaktheline/placement-breaktheline.module').then(m => m.PlacementBreakthelineModule) },
      { path: 'adoption-subsidy', loadChildren: () => import( './adoption-subsidy/adoption-subsidy.module').then(m => m.AdoptionSubsidyModule) }    
    ],
    resolve: {
      tprRecomendation: PlacementAdoptionResolverService
  }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PlacementAdoptionRoutingModule { }
