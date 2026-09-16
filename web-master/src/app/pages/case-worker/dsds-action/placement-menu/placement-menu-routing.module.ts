import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PlacementMenuComponent } from './placement-menu.component';

const routes: Routes = [{
  path: '',
  component: PlacementMenuComponent,
  children: [
        { path: 'placement', loadChildren: () => import( './../placement/placement.module').then(m => m.PlacementModule) },
        { path: 'foster-care', loadChildren: () => import( './../foster-care/foster-care.module').then(m => m.FosterCareModule) },
  ]
}];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PlacementMenuRoutingModule { }
