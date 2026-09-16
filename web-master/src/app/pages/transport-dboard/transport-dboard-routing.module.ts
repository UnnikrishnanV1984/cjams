import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TransportListComponent } from './transport-list/transport-list.component';
import { TransportRosterComponent } from './transport-roster/transport-roster.component';

const routes: Routes = [
  {
      path: '',
      children: [
          { path: '', component: TransportListComponent },
          { path: 'transport-roster', component: TransportRosterComponent }
      ]
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TransportDboardRoutingModule { }
