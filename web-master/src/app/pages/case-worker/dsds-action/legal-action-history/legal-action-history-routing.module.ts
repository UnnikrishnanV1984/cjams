import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LegalActionHistoryComponent } from './legal-action-history.component';
const routes: Routes = [
    {
    path: '',
    component: LegalActionHistoryComponent
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LegalActionHistoryRoutingModule { }
