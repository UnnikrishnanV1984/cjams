import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CwAssignmentsComponent } from './cw-assignments.component';
import { CWAssignmentResolverService } from './cw-assignments-resolver.service';
const routes: Routes = [
    {
    path: '',
    component: CwAssignmentsComponent,
    // resolve: {
    //   result: CWAssignmentResolverService
    // },
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CwAssignmentsRoutingModule { }
