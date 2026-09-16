import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AttachmentComponent } from './attachment.component';
import { AudioRecordComponent } from './audio-record/audio-record.component';
import { VideoRecordComponent } from './video-record/video-record.component';
import { ImageRecordComponent } from './image-record/image-record.component';
import { ScanAttachmentComponent } from './scan-attachment/scan-attachment.component';
import { AttachmentUploadSharedComponent  } from './../../../../shared/shared-components/attachment-upload-shared/attachment-upload-shared.component';
import {AttachmentResolverService} from './attachment-resolver-service'

const routes: Routes = [
  {
    path: '',
    component: AttachmentComponent,
    // resolve: {
    //   result: AttachmentResolverService
    // },
    children: [
        { path: 'audio-record', component: AudioRecordComponent },
        { path: 'video-record', component: VideoRecordComponent },
        { path: 'image-record', component: ImageRecordComponent },
        { path: 'scan-attachment', component: ScanAttachmentComponent},
        { path: 'attachment-upload/fileupload', component: AttachmentUploadSharedComponent },
        { path: 'attachment-upload/largefileupload', component: AttachmentUploadSharedComponent },
       { path: 'attachment-upload/fileupload/:attachmenttype/:personid', component: AttachmentUploadSharedComponent },
       { path: 'attachment-upload/largefileupload/:attachmenttype/:personid', component: AttachmentUploadSharedComponent },
        { path: 'image-record/:attachmenttype/:personid', component: ImageRecordComponent },
        { path: 'video-record/:attachmenttype/:personid', component: VideoRecordComponent },
        { path: 'audio-record/:attachmenttype/:personid', component: AudioRecordComponent },
        { path: 'scan-attachment/:attachmenttype/:personid', component: ScanAttachmentComponent }

    ]
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AttachmentRoutingModule { }