import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonYouthstatusComponent } from './person-youthstatus.component';

const routes: Routes = [{
  path: '',
  component: PersonYouthstatusComponent
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonYouthstatusRoutingModule { }
