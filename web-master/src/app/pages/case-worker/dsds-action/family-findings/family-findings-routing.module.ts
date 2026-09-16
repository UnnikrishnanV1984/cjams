import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FamilyFindingsComponent } from './family-findings.component';

const routes: Routes = [
  { path: '', component: FamilyFindingsComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FamilyFindingsRoutingModule {}