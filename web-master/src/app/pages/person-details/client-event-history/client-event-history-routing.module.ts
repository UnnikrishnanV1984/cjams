import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ClientEventHistoryComponent } from './client-event-history.component';

const routes: Routes = [
  {
    path: '',
    component: ClientEventHistoryComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ClientEventHistoryRoutingModule { }
