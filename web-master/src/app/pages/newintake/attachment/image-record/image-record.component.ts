import { HttpHeaders } from '@angular/common/http';
import { AfterViewInit, Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';

import { FileUtils } from '../../../../@core/common/file-utils';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services';
import { AppConfig } from '../../../../app.config';
import { NewUrlConfig } from '../../newintake-url.config';
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';

declare var $: any;
declare var navigator: any;
@Component({
    // tslint:disable-next-line:component-selector
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
    private imageStream: any;
    private token: AppUser;
    @ViewChild('video') video: any;
    @ViewChild('canvas') canvas: any;
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
        this.canvas.toBlob((blob) => {
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
        uploadUrl = AppConfig.baseUrl + '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber;
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
                        this.attachmentDetail.patchAttachmentDetail(response.data);
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
            tracks.forEach(function(track) {
                track.stop();
            });
            this.video.srcObject = null;
        }
    }

    private startup(video, canvas) {
        this.video = video;
        this.canvas = canvas;
        navigator.getMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
        navigator.getMedia(
            {
                video: true,
                audio: false
            },
            (stream) => {
                this.imageStream = stream;
                if (navigator.mozGetUserMedia) {
                    this.video.mozSrcObject = stream;
                } else {
                    document.querySelector('video').srcObject = stream;
                }
                this.video.play();
            },
            function(err) {
                console.error('An error occured! ' + err);
            }
        );
    }
}
