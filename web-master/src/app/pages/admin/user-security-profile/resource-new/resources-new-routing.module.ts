import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ResourceNewComponent } from './resource-new.component';

const routes: Routes = [
        {
            path: '',
            component: ResourceNewComponent
        }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ResourceNewRoutingModule { }
