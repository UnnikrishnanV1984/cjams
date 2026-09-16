import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeCommunicationsComponent } from './intake-communications.component';
import { NotesComponent } from './notes/notes.component';
import { FamilyInvolvementMeetingComponent } from './family-involvement-meeting/family-involvement-meeting.component';
import { ResourceConsultComponent } from './resource-consult/resource-consult.component';

const routes: Routes = [{
  path: '',
  component: IntakeCommunicationsComponent,
  children: [
    {
      path: 'notes',
      component: NotesComponent
    },
    {
      path: 'family-involvement-meeting',
      component: FamilyInvolvementMeetingComponent
    },
    {
      path: 'resource-consult',
      component: ResourceConsultComponent
    },
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeCommunicationsRoutingModule { }
