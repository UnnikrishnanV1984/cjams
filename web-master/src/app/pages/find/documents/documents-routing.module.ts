import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RoleGuard } from '../../../@core/guard';
import { DocumentsComponent } from './documents.component';
import { DocumentsViewComponent } from './documents-view/documents-view.component';

const routes: Routes = [
  {
      path: '',
      component: DocumentsComponent,
      canActivate: [RoleGuard],
      children: [
        { path: 'showDocumentDetails/:id', component: DocumentsViewComponent },
    ],
      data: { roles: ['admin', 'intakeuser', 'caseworker', 'reviewer'] }
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocumentsRoutingModule { }
