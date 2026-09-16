import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AttachmentComponent } from './attachment.component';
import { AudioRecordComponent } from './audio-record/audio-record.component';
import { VideoRecordComponent } from './video-record/video-record.component';
import { ImageRecordComponent } from './image-record/image-record.component';
import { ScanAttachmentComponent } from './scan-attachment/scan-attachment.component';
import { AttachmentUploadComponent } from './attachment-upload/attachment-upload.component';

const routes: Routes = [
  {
    path: '',
    component: AttachmentComponent,
    children: [
        { path: 'audio-record', component: AudioRecordComponent },
        { path: 'video-record', component: VideoRecordComponent },
        { path: 'image-record', component: ImageRecordComponent },
        { path: 'scan-attachment', component: ScanAttachmentComponent},
        { path: 'attachment-upload', component: AttachmentUploadComponent }
    ]
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AttachmentRoutingModule { }
