import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdoptionPlanningComponent } from './adoption-planning.component';

const routes: Routes = [{
  path: '',
  component: AdoptionPlanningComponent,
  children: [
    { path: 'efforts', loadChildren: () => import( './ap-adoption-efforts/ap-adoption-efforts.module').then(m => m.ApAdoptionEffortsModule) },
    { path: 'emotion-ties', loadChildren: () => import( './ap-emotional-tiles/ap-emotional-tiles.module').then(m => m.ApEmotionalTilesModule) },
    { path: 'checklist', loadChildren: () => import( './ap-chicklist/ap-chicklist.module').then(m => m.ApChicklistModule) },
    { path: 'narrative', loadChildren: () => import( './ap-narrative/ap-narrative.module').then(m => m.ApNarrativeModule) },
    { path: 'aca-form' , loadChildren: () => import( './ap-aca-form/ap-aca-form.module').then(m => m.ApAcaFormModule)}
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdoptionPlanningRoutingModule { }
