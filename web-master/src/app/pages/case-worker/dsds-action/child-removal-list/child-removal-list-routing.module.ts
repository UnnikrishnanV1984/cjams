import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ChildRemovalListComponent } from './child-removal-list.component';
const routes: Routes = [
    {
    path: '',
    component: ChildRemovalListComponent
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ChildRemovalListRoutingModule { }
