import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RelationshipNewComponent } from './relationship-new.component';
import { RelationshipResolverService } from './relationship-new-resolver.service';

const routes: Routes = [{
  path: '',
  component: RelationshipNewComponent,
  resolve:{
    result: RelationshipResolverService
  }
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RelationshipNewRoutingModule { }
