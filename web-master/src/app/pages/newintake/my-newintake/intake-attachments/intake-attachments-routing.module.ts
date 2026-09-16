import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeAttachmentsComponent } from './intake-attachments.component';
import { AudioRecordComponent } from './audio-record/audio-record.component';
import { VideoRecordComponent } from './video-record/video-record.component';
import { ImageRecordComponent } from './image-record/image-record.component';
import { AttachmentUploadSharedComponent } from './../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.component'
import { ScanAttachemntComponent } from "./scan-attachemnt/scan-attachemnt.component"
import { Form1080AComponent } from '../../../../shared/shared-components/forms/form-1080-a/form-1080-a.component';
import { Form1080BComponent } from '../../../../shared/shared-components/forms/form-1080-b/form-1080-b.component';
import { Form1080CComponent } from '../../../../shared/shared-components/forms/form-1080-c/form-1080-c.component';


const routes: Routes = [{
  path: '',
  component: IntakeAttachmentsComponent,
  children: [
    { path: 'form1080a', component: Form1080AComponent },
    { path: 'form1080b', component: Form1080BComponent },
    { path: 'form1080c', component: Form1080CComponent },
    { path: 'form1080a/:id', component: Form1080AComponent },
    { path: 'form1080b/:id', component: Form1080BComponent },
    { path: 'form1080c/:id', component: Form1080CComponent },
    { path: 'audio-record', component: AudioRecordComponent },
    { path: 'video-record', component: VideoRecordComponent },
    { path: 'image-record', component: ImageRecordComponent },
    { path: 'attachment-upload', component: AttachmentUploadSharedComponent },
    { path: 'scan-attachment', component: ScanAttachemntComponent},
  ]
},
{ path: 'generate', loadChildren: () => import( './intake-attachments-generate/intake-attachments-generate.module').then(m => m.IntakeAttachmentsGenerateModule) }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeAttachmentsRoutingModule { }
