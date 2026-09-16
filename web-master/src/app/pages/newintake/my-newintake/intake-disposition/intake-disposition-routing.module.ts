import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeDispositionComponent } from './intake-disposition.component';

const routes: Routes = [{
  path: '',
  component: IntakeDispositionComponent,
  children: [
    {
        path: 'doc',
        loadChildren: () => import( '../intake-document-creator/intake-document-creator.module').then(m => m.IntakeDocumentCreatorModule),
    }]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeDispositionRoutingModule { }
