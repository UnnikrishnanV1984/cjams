import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonTransportComponent } from './person-transport.component';
import { PersonTransportService } from './person-transport.service';

const routes: Routes = [
  {
    path: '',
    component: PersonTransportComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [PersonTransportService]
})
export class PersonTransportRoutingModule { }
