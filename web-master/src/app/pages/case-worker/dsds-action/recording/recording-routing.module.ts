import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RecordingComponent } from './recording.component';
import { NotesComponent } from './notes/notes.component';
import { FamilyInvolvementMeetingComponent } from './family-involvement-meeting/family-involvement-meeting.component';
import { ResourceConsultComponent } from './resource-consult/resource-consult.component';
import { VisitationLogComponent } from './visitation-log/visitation-log.component';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RecordingResolverService } from './recording-resolver-service';
import { DeactivateGuard } from './notes/deactivate-guard';

const routes: Routes = [{
  path: '',
  component: RecordingComponent,
  // resolve: {
  //   result: RecordingResolverService
  // },
  children: [
    {
      path: 'notes',
      component: NotesComponent,
      canDeactivate: [DeactivateGuard]
    },
    {
      path: 'family-involvement-meeting',
      component: FamilyInvolvementMeetingComponent
    },
    {
      path: 'resource-consult',
      component: ResourceConsultComponent
    },
    {
      path: 'visitation-log',
      component: VisitationLogComponent
    }
   
  ]
}];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [
    RouterModule,
    MatTooltipModule,
  ]
})
export class RecordingRoutingModule { }
