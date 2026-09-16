import { HttpHeaders } from '@angular/common/http';
import { AfterViewInit, Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';

import { FileUtils } from '../../../../../@core/common/file-utils';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AuthService, DataStoreService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare var $: any;
declare var navigator: any;
declare var window: any;
@Component({
    selector: 'image-record',
    templateUrl: './image-record.component.html',
    styleUrls: ['./image-record.component.scss'],
    standalone: false
})
export class ImageRecordComponent implements OnInit, AfterViewInit, OnDestroy {
    daNumber: string;
    id: string;
    imageBlob: any;
    tabActive = false;
    enableSave = false;
    attachmenttype='case';
    personid='';
    private imageStream: any;
    private token: AppUser;
    @ViewChild('video') video: any;
    @ViewChild('canvas') canvas: any;
    @ViewChild(AttachmentDetailComponent) attachmentDetail!: AttachmentDetailComponent;
    constructor(private route: ActivatedRoute, private _uploadService: NgxfUploaderService, private _authService: AuthService,private _dataStoreService: DataStoreService) {
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
        this.startup(this.video.nativeElement, this.canvas.nativeElement);
    }

    ngOnDestroy() {
        this.stopStreamedVideo();
    }
    captureImage() {
        const ratio = this.video.videoWidth / this.video.videoHeight;
        this.canvas.width = this.video.videoWidth - 100;
        this.canvas.height = this.canvas.width / ratio;
        this.canvas.getContext('2d').drawImage(this.video, 0, 0, this.canvas.width, this.canvas.height);
        this.canvas.toBlob((blob: any) => {
            this.imageBlob = blob;
        });
        this.enableSave = true;
    }

    saveImage() {
        const fileName = FileUtils.getFileName('png');
        const fileObject = new File([this.imageBlob], fileName, {
            type: 'image/png'
        });
        
        let uploadUrl = '';
       
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+'&attachmenttype='+this.attachmenttype+'&personid='+this.personid;
        
        this._uploadService
      .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file').set('srno', this.daNumber),
                filesKey: ['file'],
                files: fileObject,
                process: true
            })
            .subscribe(
                (response) => {
                    if (response.data) {
                        this.attachmentDetail.patchAttachmentDetail(response.data,this.attachmenttype,this.personid);
                        this.attachmentDetail.loadDropdown();
                        this.stopStreamedVideo();
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
        $('#upload-attachment').modal('hide');
    }

    stopStreamedVideo() {
        if (this.imageStream) {
            if ( this.video) {
                this.video.pause();
                this.video.src = '';
            }
            const tracks = this.imageStream.getTracks();
            tracks.forEach(function(track: any) {
                track.stop();
            });
            this.video.srcObject = null;
        }
    }

    private startup(video: any, canvas: any) {
        this.video = video;
        this.canvas = canvas;
        navigator.getMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
        navigator.getMedia(
            {
                video: true,
                audio: false
            },
            (stream: any) => {
                this.imageStream = stream;
                if (navigator.mozGetUserMedia) {
                    this.video.mozSrcObject = stream;
                } else {
                    this.video.srcObject = stream;
                }
                this.video.play();
            },
            function(err: any) {
            }
        );
    }
}