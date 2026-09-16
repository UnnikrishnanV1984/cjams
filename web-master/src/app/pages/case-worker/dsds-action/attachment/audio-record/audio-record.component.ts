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
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    selector: 'audio-record',
    templateUrl: './audio-record.component.html',
    styleUrls: ['./audio-record.component.scss'],
    standalone: false
})
export class AudioRecordComponent implements OnInit, AfterViewInit {
    daNumber: string;
    id: string;
    tabActive = false;
    record = false;
    enableSave = false;
    attachmenttype='case';
    personid='';
    private stream!: MediaStream;
    private recordRTC: any;
    private videoBlob: any;
    private token: AppUser;

    @ViewChild('audio') audio!: any;
    @ViewChild(AttachmentDetailComponent) attachmentDetail!: AttachmentDetailComponent;

    constructor(private route: ActivatedRoute, private _uploadService: NgxfUploaderService, private _authService: AuthService,private _dataStoreService: DataStoreService ){
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        if(route.snapshot.params) {
            this.attachmenttype = route.snapshot.params['attachmenttype'] || 'case';
            this.personid = route.snapshot.params['personid'] || '';
        }
    }

    ngOnInit() {
        (<any>$('#upload-attachment')).modal('show'); // NOSONAR
    }

    ngAfterViewInit() {
        const audio: HTMLAudioElement = this.audio.nativeElement;
        audio.muted = false;
        audio.controls = true;
        audio.autoplay = false;
    }

    startRecording() {
        const mediaConstraints = {
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
        }
    }

    startUpload(): void {
        const fileName = FileUtils.getFileName('mp3');
        const fileObject = new File([this.videoBlob], fileName, {
            type: 'audio/mp3'
        });
        let uploadUrl = '';
       
        uploadUrl =AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber;
             
        
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
                },
                (err) => {
                    console.error(err);
                } 
            );
    }
    modalDismiss() {
        (<any>$('#upload-attachment')).modal('hide'); // NOSONAR
    }

    private successCallback(stream: MediaStream) {
        const options: any = {
            mimeType: 'audio/mp3',
            audioBitsPerSecond: 128000,
            videoBitsPerSecond: 128000,
            bitsPerSecond: 128000 
        };
        this.stream = stream;
        this.recordRTC = new RecordRTC(stream, options);
        this.recordRTC.startRecording();
        const audio: HTMLAudioElement = this.audio.nativeElement;
        var binaryData: any = [];
        binaryData.push(stream);
        audio.src = window.URL.createObjectURL(new Blob(binaryData, {type: "audio"}));
        this.toggleControls();
    }

    private errorCallback() {
        // handle error here
    }

    private processVideo(audioVideoWebMURL: any) {
        const audio: HTMLAudioElement = this.audio.nativeElement;
        const recordRTC = this.recordRTC;
        audio.src = audioVideoWebMURL;
        this.toggleControls();
        this.videoBlob = recordRTC.getBlob();
        recordRTC.getDataURL(function(dataURL: any) {
            // No content to add or call // NOSONAR
        });
    }
    private toggleControls() {
        const audio: HTMLAudioElement = this.audio.nativeElement;
        audio.muted = !audio.muted;
        audio.controls = !audio.controls;
        audio.autoplay = !audio.autoplay;
    }
}
