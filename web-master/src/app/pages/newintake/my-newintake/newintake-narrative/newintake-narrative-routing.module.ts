import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NewintakeNarrativeComponent } from './newintake-narrative.component';

const routes: Routes = [
  {
      path: '',
      component: NewintakeNarrativeComponent
  }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class NewintakeNarrativeRoutingModule { }
