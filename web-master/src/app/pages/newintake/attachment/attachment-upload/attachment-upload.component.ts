
import {map, pluck, share} from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, Injector, OnInit  } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { forkJoin ,  Observable } from 'rxjs';

import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService } from '../../../../@core/services';
import { AppConfig } from '../../../../app.config';
import { AttachmentUpload, Attachment } from '../_entities/attachment.data.models';
import { NewUrlConfig } from '../../newintake-url.config';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-upload',
    templateUrl: './attachment-upload.component.html',
    styleUrls: ['./attachment-upload.component.scss'],
    standalone: false
})
export class AttachmentUploadComponent implements OnInit {
    curDate: Date;
    fileToSave = [];
    uploadedFile = [];
    tabActive = false;
    daNumber: string;
    id: string;
    attachmentResponse: AttachmentUpload;
    // attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$: Observable<DropdownModel[]>;
    token: AppUser;
    attachmentClassificationtypelookup = [];
    attachmentClassificationtype = [];
    isAttachType = '';
    isCate = '';
    issubCate= '';
    isCW: boolean;
    uploadattachmentpopupid = '#upload-attachment';

    private router: Router;
    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private _alertService: AlertService;

        
    constructor( private injector : Injector, private _service: GenericService<Attachment>) {
        this.router = this.injector.get<Router>(Router);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);

        this.id = this.route.snapshot.parent.parent.parent.parent.parent.params['id'];
        this.daNumber = this.route.snapshot.parent.parent.parent.parent.parent.params['daNumber'];
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.curDate = new Date();
        $(this.uploadattachmentpopupid).modal('show');
    }

    uploadFile(file: File | FileError): void {
        if (!(file instanceof Array)) {
            return;
        }
        file.map((item, index) => {
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
            if (
                fileExt === 'mp3' ||
                fileExt === 'ogg' ||
                fileExt === 'wav' ||
                fileExt === 'acc' ||
                fileExt === 'flac' ||
                fileExt === 'aiff' ||
                fileExt === 'mp4' ||
                fileExt === 'mov' ||
                fileExt === 'avi' ||
                fileExt === '3gp' ||
                fileExt === 'wmv' ||
                fileExt === 'mpeg-4' ||
                fileExt === 'pdf' ||
                fileExt === 'txt' ||
                fileExt === 'docx' ||
                fileExt === 'doc' ||
                fileExt === 'xls' ||
                fileExt === 'xlsx' ||
                fileExt === 'jpeg' ||
                fileExt === 'jpg' ||
                fileExt === 'png' ||
                fileExt === 'ppt' ||
                fileExt === 'pptx' ||
                fileExt === 'gif' ||
                fileExt === 'cr2' ||
                fileExt === 'rtf'
            ) {
                const filenameOnly = item.name.toLowerCase().split('.'+fileExt)[0];
                if(!filenameOnly.match(/^([a-zA-Z0-9\s\._-]+)?$/))
                {
                    this._alertService.error("The file " + item.name + " can't be uploaded. File name should not contain any special characters.");
                    return;
                }
                this.uploadedFile.push(item);
                this.uploadAttachment(index);
                const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
                const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
                if ( audio_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Audio'
                } else if ( video_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Video';
                } else {
                    this.uploadedFile[index].attachmenttypekey = 'Document';
                }
                this.isAttachType = this.uploadedFile[index].attachmenttypekey;
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error(fileExt + " format can't be uploaded");
            }
        });
    }

    humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    uploadAttachment(index) {
        this.isAttachType = '';
        this.isCate = '';
        const _self = this;
        const isDataFilled =  setInterval(function() {
                if (_self.isAttachType !== '' && _self.isCate !== ''  &&  _self.issubCate !== ''  ) {
                    
                    clearInterval(isDataFilled);
                    _self.processResponseData(index);
                }  
          }, 1000);

        
    }

    processResponseData(index) {
         
        let uploadUrl = '';
        uploadUrl = AppConfig.baseUrl + '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber + '&objecttypekey=' + 'ServiceRequest';
            
        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true,
            })
            .subscribe(
                (response) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
                    if (response.status === 1 && response.data) {
                        this.attachmentResponse = response.data;
                        this.fileToSave.push(response.data);
                        this.fileToSave[this.fileToSave.length - 1].documentattachment = {
                            attachmenttypekey: this.isAttachType,
                            attachmentclassificationtypekey: this.isCate,
                            attachmentclassificationsubtypekey: this.issubCate,
                            attachmentdate: new Date(),
                            sourceauthor: '',
                            attachmentsubject: '',
                            sourceposition: '',
                            attachmentpurpose: '',
                            sourcephonenumber: '',
                            acquisitionmethod: '',
                            sourceaddress: '',
                            locationoforiginal: '',
                            insertedby: this.token.user.userprofile.displayname,
                            note: '',
                            updatedby: this.token.user.userprofile.displayname,
                            activeflag: 1
                        };
                        this.fileToSave[this.fileToSave.length - 1].description = '';
                        this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
                        this.fileToSave[this.fileToSave.length - 1].title = '';
                        this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
                        this.fileToSave[this.fileToSave.length - 1].objecttypekey = 'ServiceRequest';
                        this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = 'ServiceRequest';
                        this.fileToSave[this.fileToSave.length - 1].activeflag = 1;
                        this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
                        this.fileToSave[this.fileToSave.length - 1].insertedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].updatedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].securityusersid = this.token.user.userprofile.securityusersid;
                    }

                }, (err) => {
                        console.error(err);
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                        this.uploadedFile.splice(index, 1);
                    }
                );
    }
    deleteUpload(index) {
        this.uploadedFile.splice(index, 1);
        this.fileToSave.splice(index, 1);
    }
    clearAllUpload() {
        $(this.uploadattachmentpopupid).modal('hide');
        this.uploadedFile = [];
        this.fileToSave = [];
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }
    titleUpdate(event, index) {
        this.uploadedFile[index].title = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidTitle = false;
        } else {
            this.uploadedFile[index].invalidTitle = true;
        }
    }
    descUpdate(event, index) {
        this.uploadedFile[index].description = event.target.value;
    }
    docDateUpdate(event, index) {
        this.uploadedFile[index].docDate = event.target.value;
    }
    typeUpdate(event, index) {
        if (event.target.value !== '')  {
            this.isAttachType  = event.target.value;
        }
        this.uploadedFile[index].attachmenttypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentType = false;
        } else {
            this.uploadedFile[index].invalidAttachmentType = true;
        }
    }
    categoryUpdate(event, index) {
        if (event.target.value !== '')  {
            this.isCate  = event.target.value;
        }
        this.issubCate  = '';
        this.uploadedFile[index].attachmentclassificationsubtypekey = '';
        this.uploadedFile[index].attachmentClassificationsubtype = [];
        this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentClassify = false;
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                    this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory: element.subcategory});
                }
            }
        } else {
            this.uploadedFile[index].invalidAttachmentClassify = true;
        }
    }
    subcategoryUpdate(event, index) {
        if (event.target.value !== '')  {
            this.issubCate  = event.target.value;
        }
        this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentsubClassify = false;
        } else {
            this.uploadedFile[index].invalidAttachmentsubClassify = true;
        }
    }
    saveAttachmentDetails() {
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.uploadedFile.forEach((item, index) => {
                this.fileToSave[index].servicerequestid = this.id;
                this.fileToSave[index].title = item.title;
                this.fileToSave[index].description = item.description;
                this.fileToSave[index].documentattachment.attachmenttypekey = item.attachmenttypekey;
                this.fileToSave[index].documentattachment.attachmentclassificationtypekey = item.attachmentclassificationtypekey;
                this.fileToSave[index].documentattachment.attachmentclassificationsubtypekey = item.attachmentclassificationsubtypekey;
            });
            const AttachValidate = this.fileToSave.filter((wer) => !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.title  || !wer.documentattachment.attachmentclassificationsubtypekey /*|| !wer.documentattachment.administration  || !wer.documentattachment.site */ );
            if (AttachValidate.length === 0) {
                this._service.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
                this._service.createArrayList(this.fileToSave).subscribe(
                    (response) => {
                        response.forEach((item, index) => {
                            this.saveAttachmentApiResponseFn(item, response, index);
                        });
                    },
                    (error) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error('Please fill all mandatory fields');
                this.uploadedFile.forEach((item) => {
                    this.attachValidateElseCondFn(item);
                });
            }
        }
    }
    private saveAttachmentApiResponseFn(item: Attachment, response: Attachment[], index: number) {
        if (item.documentpropertiesid) {
            response.splice(index, 1);
            this.fileToSave.splice(index, 1);
            this.uploadedFile.splice(index, 1);
        }
        const docProp = response.filter((docId) => docId.Documentattachment);
        if (docProp.length === 0) {
            this._alertService.success('Attachment(s) added successfully!');
            $(this.uploadattachmentpopupid).modal('hide');
            this.fileToSave = [];
            this.uploadedFile = [];
            this.router.routeReuseStrategy.shouldReuseRoute = function () {
                return false;
            };
            const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
            this.router.navigate([currentUrl]);
        }
        if (item.Documentattachment) {
            const attPos = index + 1;
            this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
        } else if (!item.documentpropertiesid) {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    }

    private attachValidateElseCondFn(item: any) {
        if (!item.title) {
            item.invalidTitle = true;
        } else {
            item.invalidTitle = false;
        }
        if (!item.attachmentclassificationtypekey) {
            item.invalidAttachmentClassify = true;
        } else {
            item.invalidAttachmentClassify = false;
        }
        if (!item.attachmenttypekey) {
            item.invalidAttachmentType = true;
        } else {
            item.invalidAttachmentType = false;
        }
        if (!item.attachmentclassificationsubtypekey) {
            item.invalidAttachmentsubClassify = true;
        } else {
            item.invalidAttachmentsubClassify = false;
        }
    }

    private loadDropdown() {
        this._dropDownService
        .getSingle(
            {},
            NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
        )
        .subscribe(data => {
            const dp_att_arr = [];
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                for (const element of this.attachmentClassificationtypelookup) {
                    if (element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0 ) {
                        this.attachmentClassificationtypelookupLoopFn(element, dp_att_arr);
                    }
                }

            }
        });
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
            ),
            ]).pipe(
            map((result) => {
                return {
                    attachmentType: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.attachmenttypekey
                            })
                    ),
                };
            }),
            share(),);
        this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
    }

    private attachmentClassificationtypelookupLoopFn(element: any, dp_att_arr: any[]) {
        if (this.isCW) {
            if (element.typedescription.startsWith('CW-')) {
                this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                dp_att_arr.push(element.typedescription);
            }
        } else {
            this.attachmentClassificationtype.push({ typedescription: element.typedescription });
            dp_att_arr.push(element.typedescription);
        }
    }

    onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}
