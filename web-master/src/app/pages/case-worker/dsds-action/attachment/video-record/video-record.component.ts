import { HttpHeaders } from '@angular/common/http';
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import RecordRTC from 'recordrtc';

import { FileUtils } from '../../../../../@core/common/file-utils';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AuthService, DataStoreService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { AttachmentDetailComponent } from './../attachment-detail/attachment-detail.component';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

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
    attachmenttype='case';
    personid='';
    private videoBlob!: Blob;
    private stream!: MediaStream;
    private recordRTC: any;
    private token: AppUser;
    @ViewChild('video') video!: any;
    @ViewChild(AttachmentDetailComponent) attachmentDetail!: AttachmentDetailComponent;

    constructor(private route: ActivatedRoute, private _uploadService: NgxfUploaderService, private _authService: AuthService, private _dataStoreService: DataStoreService) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        if(route.snapshot.params) {
            this.attachmenttype = route.snapshot.params['attachmenttype'] || 'case';
            this.personid = route.snapshot.params['personid'] || '';
        }
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
        
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl
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
                        this.attachmentDetail.patchAttachmentDetail(response.data,this.attachmenttype,this.personid);
                        this.attachmentDetail.loadDropdown();
                        this.tabActive = true;
                        $('#step1').removeClass('active');
                        $('#complete').addClass('active');
                    }
                }
            );
    }
    modalDismiss() {
        $('#upload-attachment').modal('hide');
    }

    private successCallback(stream: MediaStream) {
        const options: any = {
            mimeType: 'video/webm', // or video/webm\;codecs=h264 or video/webm\;codecs=vp9
                audioBitsPerSecond: 128000,
                videoBitsPerSecond: 128000,
            bitsPerSecond: 128000 // if this line is provided, skip above two
        };
        this.stream = stream;
        this.recordRTC = new RecordRTC(stream, options);
        this.recordRTC.startRecording();
        const video: HTMLVideoElement = this.video.nativeElement;
        video.srcObject  = stream;
        this.toggleControls();
    }

    private errorCallback() {
        // handle error here
    }

    private processVideo(audioVideoWebMURL: any) {
        const video: HTMLVideoElement = this.video.nativeElement;
        const recordRTC = this.recordRTC;
        video.src = audioVideoWebMURL;
        this.toggleControls();
        this.videoBlob = recordRTC.getBlob();
        recordRTC.getDataURL(function(dataURL: any) {
            // No content to add or call // NOSONAR
        });
    }
    private toggleControls() {
        const video: HTMLVideoElement = this.video.nativeElement;
        video.muted = !video.muted;
        video.controls = !video.controls;
        video.autoplay = !video.autoplay;
    }
}
