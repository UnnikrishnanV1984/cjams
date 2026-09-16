import { HttpHeaders } from '@angular/common/http';
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import * as RecordRTC from 'recordrtc/RecordRTC.min';

import { FileUtils } from '../../../../@core/common/file-utils';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services';
import { AppConfig } from '../../../../app.config';
import { NewUrlConfig } from '../../newintake-url.config';
import { AttachmentDetailComponent } from './../attachment-detail/attachment-detail.component';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'video-record',
    templateUrl: './video-record.component.html',
    styleUrls: ['./video-record.component.scss'],
    standalone: false
})
export class VideoRecordComponent implements OnInit, AfterViewInit {
    daNumber: string;
    id: string;
    record = false;
    tabActive = false;
    enableSave = false;
    private videoBlob: Blob;
    private stream: MediaStream;
    private recordRTC: any;
    private token: AppUser;
    @ViewChild('video') video;
    @ViewChild(AttachmentDetailComponent) attachmentDetail: AttachmentDetailComponent;

    constructor(private route: ActivatedRoute, private _uploadService: NgxfUploaderService, private _authService: AuthService) {
        this.id = route.snapshot.parent.parent.parent.parent.parent.params['id'];
        this.daNumber = route.snapshot.parent.parent.parent.parent.parent.params['daNumber'];
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        $('#upload-attachment').modal('show');
    }

    ngAfterViewInit() {
        const video: HTMLVideoElement = this.video.nativeElement;
        video.muted = false;
        video.controls = true;
        video.autoplay = false;
    }

    startRecording() {
        const mediaConstraints = {
            video: {
                width: 640,
                height: 360
            },
            audio: true
        };
        navigator.mediaDevices.getUserMedia(mediaConstraints).then(this.successCallback.bind(this), this.errorCallback.bind(this));
        this.record = true;
    }

    stopRecording() {
        this.record = false;
        this.enableSave = true;
        if (this.recordRTC) {
            this.recordRTC.stopRecording(this.processVideo.bind(this));
            const stream = this.stream;
            stream.getAudioTracks().forEach((track) => track.stop());
            stream.getVideoTracks().forEach((track) => track.stop());
        }
    }
    startUpload(): void {
        const fileName = FileUtils.getFileName('webm');
        // we need to upload "File" --- not "Blob"
        const fileObject = new File([this.videoBlob], fileName, {
            type: 'video/webm'
        });

        let uploadUrl = '';
     
          uploadUrl = AppConfig.baseUrl + '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl
            + '?srno=' + this.daNumber;

        

        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders()
                    .set('ctype', 'file')
                    .set('srno', this.daNumber),
                filesKey: ['file'],
                files: fileObject,
                process: true
            })
            .subscribe(
                (response) => {
                    if (response.data) {
                        this.attachmentDetail.patchAttachmentDetail(response.data);
                        this.attachmentDetail.loadDropdown();
                        this.tabActive = true;
                        $('#step1').removeClass('active');
                        $('#complete').addClass('active');
                    }
                },
                (err) => {
                    // No data or function to add or call
                }
            );
    }
    modalDismiss() {
        $('#upload-attachment').modal('hide');
    }

    private successCallback(stream: MediaStream) {
        const options = {
            mimeType: 'video/webm', // or video/webm\;codecs=h264 or video/webm\;codecs=vp9
                audioBitsPerSecond: 128000,
                videoBitsPerSecond: 128000,
            bitsPerSecond: 128000 // if this line is provided, skip above two
        };
        this.stream = stream;
        this.recordRTC = RecordRTC(stream, options);
        this.recordRTC.startRecording();
        document.querySelector('video').srcObject = stream;

        this.toggleControls();
    }

    private errorCallback() {
        // handle error here
    }

    private processVideo(audioVideoWebMURL) {
        const video: HTMLVideoElement = this.video.nativeElement;
        const recordRTC = this.recordRTC;
        video.src = audioVideoWebMURL;
        this.toggleControls();
        this.videoBlob = recordRTC.getBlob();
        recordRTC.getDataURL(function(dataURL) {
            // No content to add or call
        });
    }
    private toggleControls() {
        const video: HTMLVideoElement = this.video.nativeElement;
        video.muted = !video.muted;
        video.controls = !video.controls;
        video.autoplay = !video.autoplay;
    }
}
