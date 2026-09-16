import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonDocumentsComponent } from './person-documents.component';
import { PersonDocumentsResolverService } from './person-documents-resolver.service';

const routes: Routes = [{
  path: '',
  component: PersonDocumentsComponent,
  resolve: {
    items: PersonDocumentsResolverService
  }
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonDocumentsRoutingModule { }
